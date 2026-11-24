import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

class LocalPart extends Table {
  IntColumn get id => integer()();
  TextColumn get codigo => text()();
  TextColumn get nombre => text()();
  TextColumn get descripcion => text().nullable()();
  TextColumn get categoria => text().nullable()();
  TextColumn get marca => text().nullable()();
  RealColumn get precioCompra => real()();
  RealColumn get precioVenta => real()();
  IntColumn get stock => integer()();
  IntColumn get stockMinimo => integer()();
  TextColumn get ubicacion => text().nullable()();
  BoolColumn get activo => boolean()();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalApartado extends Table {
  IntColumn get id => integer()();
  IntColumn get clienteId => integer()();
  IntColumn get piezaId => integer()();
  IntColumn get cantidad => integer()();
  TextColumn get estado => text()();
  DateTimeColumn get fechaCreacion => dateTime()();
  DateTimeColumn get fechaExpiracion => dateTime().nullable()();
  TextColumn get nota => text().nullable()();
  TextColumn get piezaJson => text()();
  BoolColumn get expirado => boolean()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncMetadata extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [LocalPart, LocalApartado, SyncMetadata])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  static LocalDatabase? _instance;

  static LocalDatabase get instance {
    _instance ??= LocalDatabase(_openConnection());
    return _instance!;
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbDir = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dbDir.path, 'refaccionaria.db'));
      return NativeDatabase.createInBackground(dbFile);
    });
  }

  Future<void> cacheParts(List<Map<String, dynamic>> parts) async {
    final now = DateTime.now();
    for (final part in parts) {
      await into(localPart).insertOnConflictUpdate(
        LocalPartCompanion(
          id: Value(part['id'] as int),
          codigo: Value(part['codigo'] as String),
          nombre: Value(part['nombre'] as String),
          descripcion: Value(part['descripcion'] as String?),
          categoria: Value(part['categoria'] as String?),
          marca: Value(part['marca'] as String?),
          precioCompra: Value((part['precioCompra'] as num).toDouble()),
          precioVenta: Value((part['precioVenta'] as num).toDouble()),
          stock: Value(part['stock'] as int),
          stockMinimo: Value(part['stockMinimo'] as int),
          ubicacion: Value(part['ubicacion'] as String?),
          activo: Value(part['activo'] as bool),
          lastUpdated: Value(now),
        ),
      );
    }
    await _updateMetadata('parts_last_updated', now.toIso8601String());
  }

  Future<List<LocalPartData>> getCachedParts() async {
    return select(localPart).get();
  }

  Future<DateTime?> getPartsLastUpdated() async {
    final metadata = await (select(syncMetadata)
          ..where((t) => t.key.equals('parts_last_updated')))
        .getSingleOrNull();
    if (metadata == null) return null;
    return DateTime.parse(metadata.value);
  }

  Future<void> cacheApartados(List<Map<String, dynamic>> apartados) async {
    final now = DateTime.now();
    for (final apartado in apartados) {
      await into(localApartado).insertOnConflictUpdate(
        LocalApartadoCompanion(
          id: Value(apartado['id'] as int),
          clienteId: Value(apartado['clienteId'] as int),
          piezaId: Value(apartado['piezaId'] as int),
          cantidad: Value(apartado['cantidad'] as int),
          estado: Value(apartado['estado'] as String),
          fechaCreacion: Value(DateTime.parse(apartado['fechaCreacion'] as String)),
          fechaExpiracion: apartado['fechaExpiracion'] != null
              ? Value(DateTime.parse(apartado['fechaExpiracion'] as String))
              : const Value.absent(),
          nota: Value(apartado['nota'] as String?),
          piezaJson: Value(_encodePieza(apartado['pieza'])),
          expirado: Value(apartado['expirado'] as bool? ?? false),
          lastUpdated: Value(now),
        ),
      );
    }
  }

  Future<List<LocalApartadoData>> getCachedApartados() async {
    return select(localApartado).get();
  }

  Future<void> savePendingApartado(Map<String, dynamic> apartado) async {
    final now = DateTime.now();
    await into(localApartado).insert(
      LocalApartadoCompanion(
        id: Value(apartado['id'] as int),
        clienteId: Value(apartado['clienteId'] as int),
        piezaId: Value(apartado['piezaId'] as int),
        cantidad: Value(apartado['cantidad'] as int),
        estado: Value(apartado['estado'] as String),
        fechaCreacion: Value(DateTime.parse(apartado['fechaCreacion'] as String)),
        fechaExpiracion: apartado['fechaExpiracion'] != null
            ? Value(DateTime.parse(apartado['fechaExpiracion'] as String))
            : const Value.absent(),
        nota: Value(apartado['nota'] as String?),
        piezaJson: Value(_encodePieza(apartado['pieza'])),
        expirado: Value(apartado['expirado'] as bool? ?? false),
        pendingSync: const Value(true),
        lastUpdated: Value(now),
      ),
    );
  }

  Future<List<LocalApartadoData>> getPendingApartados() async {
    return (select(localApartado)..where((t) => t.pendingSync.equals(true))).get();
  }

  Future<void> markAsSynced(int id) async {
    await (update(localApartado)..where((t) => t.id.equals(id)))
        .write(LocalApartadoCompanion(pendingSync: const Value(false)));
  }

  Future<void> deleteApartado(int id) async {
    await (delete(localApartado)..where((t) => t.id.equals(id))).go();
  }

  String _encodePieza(dynamic pieza) {
    if (pieza is String) return pieza;
    return jsonEncode(pieza ?? {});
  }

  Future<void> _updateMetadata(String key, String value) async {
    await into(syncMetadata).insertOnConflictUpdate(
      SyncMetadataCompanion(
        key: Value(key),
        value: Value(value),
        lastUpdated: Value(DateTime.now()),
      ),
    );
  }
}
