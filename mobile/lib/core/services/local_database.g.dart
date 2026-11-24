// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $LocalPartTable extends LocalPart
    with TableInfo<$LocalPartTable, LocalPartData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPartTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
      'marca', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _precioCompraMeta =
      const VerificationMeta('precioCompra');
  @override
  late final GeneratedColumn<double> precioCompra = GeneratedColumn<double>(
      'precio_compra', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _precioVentaMeta =
      const VerificationMeta('precioVenta');
  @override
  late final GeneratedColumn<double> precioVenta = GeneratedColumn<double>(
      'precio_venta', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stockMinimoMeta =
      const VerificationMeta('stockMinimo');
  @override
  late final GeneratedColumn<int> stockMinimo = GeneratedColumn<int>(
      'stock_minimo', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ubicacionMeta =
      const VerificationMeta('ubicacion');
  @override
  late final GeneratedColumn<String> ubicacion = GeneratedColumn<String>(
      'ubicacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
      'activo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("activo" IN (0, 1))'));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        codigo,
        nombre,
        descripcion,
        categoria,
        marca,
        precioCompra,
        precioVenta,
        stock,
        stockMinimo,
        ubicacion,
        activo,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_part';
  @override
  VerificationContext validateIntegrity(Insertable<LocalPartData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    }
    if (data.containsKey('marca')) {
      context.handle(
          _marcaMeta, marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta));
    }
    if (data.containsKey('precio_compra')) {
      context.handle(
          _precioCompraMeta,
          precioCompra.isAcceptableOrUnknown(
              data['precio_compra']!, _precioCompraMeta));
    } else if (isInserting) {
      context.missing(_precioCompraMeta);
    }
    if (data.containsKey('precio_venta')) {
      context.handle(
          _precioVentaMeta,
          precioVenta.isAcceptableOrUnknown(
              data['precio_venta']!, _precioVentaMeta));
    } else if (isInserting) {
      context.missing(_precioVentaMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
          _stockMinimoMeta,
          stockMinimo.isAcceptableOrUnknown(
              data['stock_minimo']!, _stockMinimoMeta));
    } else if (isInserting) {
      context.missing(_stockMinimoMeta);
    }
    if (data.containsKey('ubicacion')) {
      context.handle(_ubicacionMeta,
          ubicacion.isAcceptableOrUnknown(data['ubicacion']!, _ubicacionMeta));
    }
    if (data.containsKey('activo')) {
      context.handle(_activoMeta,
          activo.isAcceptableOrUnknown(data['activo']!, _activoMeta));
    } else if (isInserting) {
      context.missing(_activoMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPartData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPartData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria']),
      marca: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marca']),
      precioCompra: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}precio_compra'])!,
      precioVenta: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}precio_venta'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      stockMinimo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_minimo'])!,
      ubicacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ubicacion']),
      activo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}activo'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $LocalPartTable createAlias(String alias) {
    return $LocalPartTable(attachedDatabase, alias);
  }
}

class LocalPartData extends DataClass implements Insertable<LocalPartData> {
  final int id;
  final String codigo;
  final String nombre;
  final String? descripcion;
  final String? categoria;
  final String? marca;
  final double precioCompra;
  final double precioVenta;
  final int stock;
  final int stockMinimo;
  final String? ubicacion;
  final bool activo;
  final DateTime lastUpdated;
  const LocalPartData(
      {required this.id,
      required this.codigo,
      required this.nombre,
      this.descripcion,
      this.categoria,
      this.marca,
      required this.precioCompra,
      required this.precioVenta,
      required this.stock,
      required this.stockMinimo,
      this.ubicacion,
      required this.activo,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['codigo'] = Variable<String>(codigo);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    if (!nullToAbsent || marca != null) {
      map['marca'] = Variable<String>(marca);
    }
    map['precio_compra'] = Variable<double>(precioCompra);
    map['precio_venta'] = Variable<double>(precioVenta);
    map['stock'] = Variable<int>(stock);
    map['stock_minimo'] = Variable<int>(stockMinimo);
    if (!nullToAbsent || ubicacion != null) {
      map['ubicacion'] = Variable<String>(ubicacion);
    }
    map['activo'] = Variable<bool>(activo);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  LocalPartCompanion toCompanion(bool nullToAbsent) {
    return LocalPartCompanion(
      id: Value(id),
      codigo: Value(codigo),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      marca:
          marca == null && nullToAbsent ? const Value.absent() : Value(marca),
      precioCompra: Value(precioCompra),
      precioVenta: Value(precioVenta),
      stock: Value(stock),
      stockMinimo: Value(stockMinimo),
      ubicacion: ubicacion == null && nullToAbsent
          ? const Value.absent()
          : Value(ubicacion),
      activo: Value(activo),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory LocalPartData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPartData(
      id: serializer.fromJson<int>(json['id']),
      codigo: serializer.fromJson<String>(json['codigo']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      categoria: serializer.fromJson<String?>(json['categoria']),
      marca: serializer.fromJson<String?>(json['marca']),
      precioCompra: serializer.fromJson<double>(json['precioCompra']),
      precioVenta: serializer.fromJson<double>(json['precioVenta']),
      stock: serializer.fromJson<int>(json['stock']),
      stockMinimo: serializer.fromJson<int>(json['stockMinimo']),
      ubicacion: serializer.fromJson<String?>(json['ubicacion']),
      activo: serializer.fromJson<bool>(json['activo']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'codigo': serializer.toJson<String>(codigo),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'categoria': serializer.toJson<String?>(categoria),
      'marca': serializer.toJson<String?>(marca),
      'precioCompra': serializer.toJson<double>(precioCompra),
      'precioVenta': serializer.toJson<double>(precioVenta),
      'stock': serializer.toJson<int>(stock),
      'stockMinimo': serializer.toJson<int>(stockMinimo),
      'ubicacion': serializer.toJson<String?>(ubicacion),
      'activo': serializer.toJson<bool>(activo),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  LocalPartData copyWith(
          {int? id,
          String? codigo,
          String? nombre,
          Value<String?> descripcion = const Value.absent(),
          Value<String?> categoria = const Value.absent(),
          Value<String?> marca = const Value.absent(),
          double? precioCompra,
          double? precioVenta,
          int? stock,
          int? stockMinimo,
          Value<String?> ubicacion = const Value.absent(),
          bool? activo,
          DateTime? lastUpdated}) =>
      LocalPartData(
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
        categoria: categoria.present ? categoria.value : this.categoria,
        marca: marca.present ? marca.value : this.marca,
        precioCompra: precioCompra ?? this.precioCompra,
        precioVenta: precioVenta ?? this.precioVenta,
        stock: stock ?? this.stock,
        stockMinimo: stockMinimo ?? this.stockMinimo,
        ubicacion: ubicacion.present ? ubicacion.value : this.ubicacion,
        activo: activo ?? this.activo,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  LocalPartData copyWithCompanion(LocalPartCompanion data) {
    return LocalPartData(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      marca: data.marca.present ? data.marca.value : this.marca,
      precioCompra: data.precioCompra.present
          ? data.precioCompra.value
          : this.precioCompra,
      precioVenta:
          data.precioVenta.present ? data.precioVenta.value : this.precioVenta,
      stock: data.stock.present ? data.stock.value : this.stock,
      stockMinimo:
          data.stockMinimo.present ? data.stockMinimo.value : this.stockMinimo,
      ubicacion: data.ubicacion.present ? data.ubicacion.value : this.ubicacion,
      activo: data.activo.present ? data.activo.value : this.activo,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPartData(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoria: $categoria, ')
          ..write('marca: $marca, ')
          ..write('precioCompra: $precioCompra, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('stock: $stock, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('activo: $activo, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      codigo,
      nombre,
      descripcion,
      categoria,
      marca,
      precioCompra,
      precioVenta,
      stock,
      stockMinimo,
      ubicacion,
      activo,
      lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPartData &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.categoria == this.categoria &&
          other.marca == this.marca &&
          other.precioCompra == this.precioCompra &&
          other.precioVenta == this.precioVenta &&
          other.stock == this.stock &&
          other.stockMinimo == this.stockMinimo &&
          other.ubicacion == this.ubicacion &&
          other.activo == this.activo &&
          other.lastUpdated == this.lastUpdated);
}

class LocalPartCompanion extends UpdateCompanion<LocalPartData> {
  final Value<int> id;
  final Value<String> codigo;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<String?> categoria;
  final Value<String?> marca;
  final Value<double> precioCompra;
  final Value<double> precioVenta;
  final Value<int> stock;
  final Value<int> stockMinimo;
  final Value<String?> ubicacion;
  final Value<bool> activo;
  final Value<DateTime> lastUpdated;
  const LocalPartCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.categoria = const Value.absent(),
    this.marca = const Value.absent(),
    this.precioCompra = const Value.absent(),
    this.precioVenta = const Value.absent(),
    this.stock = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.activo = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  LocalPartCompanion.insert({
    this.id = const Value.absent(),
    required String codigo,
    required String nombre,
    this.descripcion = const Value.absent(),
    this.categoria = const Value.absent(),
    this.marca = const Value.absent(),
    required double precioCompra,
    required double precioVenta,
    required int stock,
    required int stockMinimo,
    this.ubicacion = const Value.absent(),
    required bool activo,
    required DateTime lastUpdated,
  })  : codigo = Value(codigo),
        nombre = Value(nombre),
        precioCompra = Value(precioCompra),
        precioVenta = Value(precioVenta),
        stock = Value(stock),
        stockMinimo = Value(stockMinimo),
        activo = Value(activo),
        lastUpdated = Value(lastUpdated);
  static Insertable<LocalPartData> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<String>? categoria,
    Expression<String>? marca,
    Expression<double>? precioCompra,
    Expression<double>? precioVenta,
    Expression<int>? stock,
    Expression<int>? stockMinimo,
    Expression<String>? ubicacion,
    Expression<bool>? activo,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (categoria != null) 'categoria': categoria,
      if (marca != null) 'marca': marca,
      if (precioCompra != null) 'precio_compra': precioCompra,
      if (precioVenta != null) 'precio_venta': precioVenta,
      if (stock != null) 'stock': stock,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
      if (ubicacion != null) 'ubicacion': ubicacion,
      if (activo != null) 'activo': activo,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  LocalPartCompanion copyWith(
      {Value<int>? id,
      Value<String>? codigo,
      Value<String>? nombre,
      Value<String?>? descripcion,
      Value<String?>? categoria,
      Value<String?>? marca,
      Value<double>? precioCompra,
      Value<double>? precioVenta,
      Value<int>? stock,
      Value<int>? stockMinimo,
      Value<String?>? ubicacion,
      Value<bool>? activo,
      Value<DateTime>? lastUpdated}) {
    return LocalPartCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      categoria: categoria ?? this.categoria,
      marca: marca ?? this.marca,
      precioCompra: precioCompra ?? this.precioCompra,
      precioVenta: precioVenta ?? this.precioVenta,
      stock: stock ?? this.stock,
      stockMinimo: stockMinimo ?? this.stockMinimo,
      ubicacion: ubicacion ?? this.ubicacion,
      activo: activo ?? this.activo,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (precioCompra.present) {
      map['precio_compra'] = Variable<double>(precioCompra.value);
    }
    if (precioVenta.present) {
      map['precio_venta'] = Variable<double>(precioVenta.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<int>(stockMinimo.value);
    }
    if (ubicacion.present) {
      map['ubicacion'] = Variable<String>(ubicacion.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPartCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoria: $categoria, ')
          ..write('marca: $marca, ')
          ..write('precioCompra: $precioCompra, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('stock: $stock, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('activo: $activo, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $LocalApartadoTable extends LocalApartado
    with TableInfo<$LocalApartadoTable, LocalApartadoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalApartadoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
      'cliente_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _piezaIdMeta =
      const VerificationMeta('piezaId');
  @override
  late final GeneratedColumn<int> piezaId = GeneratedColumn<int>(
      'pieza_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaCreacionMeta =
      const VerificationMeta('fechaCreacion');
  @override
  late final GeneratedColumn<DateTime> fechaCreacion =
      GeneratedColumn<DateTime>('fecha_creacion', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fechaExpiracionMeta =
      const VerificationMeta('fechaExpiracion');
  @override
  late final GeneratedColumn<DateTime> fechaExpiracion =
      GeneratedColumn<DateTime>('fecha_expiracion', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notaMeta = const VerificationMeta('nota');
  @override
  late final GeneratedColumn<String> nota = GeneratedColumn<String>(
      'nota', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _piezaJsonMeta =
      const VerificationMeta('piezaJson');
  @override
  late final GeneratedColumn<String> piezaJson = GeneratedColumn<String>(
      'pieza_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _expiradoMeta =
      const VerificationMeta('expirado');
  @override
  late final GeneratedColumn<bool> expirado = GeneratedColumn<bool>(
      'expirado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("expirado" IN (0, 1))'));
  static const VerificationMeta _pendingSyncMeta =
      const VerificationMeta('pendingSync');
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
      'pending_sync', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pending_sync" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clienteId,
        piezaId,
        cantidad,
        estado,
        fechaCreacion,
        fechaExpiracion,
        nota,
        piezaJson,
        expirado,
        pendingSync,
        lastUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_apartado';
  @override
  VerificationContext validateIntegrity(Insertable<LocalApartadoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    } else if (isInserting) {
      context.missing(_clienteIdMeta);
    }
    if (data.containsKey('pieza_id')) {
      context.handle(_piezaIdMeta,
          piezaId.isAcceptableOrUnknown(data['pieza_id']!, _piezaIdMeta));
    } else if (isInserting) {
      context.missing(_piezaIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
          _fechaCreacionMeta,
          fechaCreacion.isAcceptableOrUnknown(
              data['fecha_creacion']!, _fechaCreacionMeta));
    } else if (isInserting) {
      context.missing(_fechaCreacionMeta);
    }
    if (data.containsKey('fecha_expiracion')) {
      context.handle(
          _fechaExpiracionMeta,
          fechaExpiracion.isAcceptableOrUnknown(
              data['fecha_expiracion']!, _fechaExpiracionMeta));
    }
    if (data.containsKey('nota')) {
      context.handle(
          _notaMeta, nota.isAcceptableOrUnknown(data['nota']!, _notaMeta));
    }
    if (data.containsKey('pieza_json')) {
      context.handle(_piezaJsonMeta,
          piezaJson.isAcceptableOrUnknown(data['pieza_json']!, _piezaJsonMeta));
    } else if (isInserting) {
      context.missing(_piezaJsonMeta);
    }
    if (data.containsKey('expirado')) {
      context.handle(_expiradoMeta,
          expirado.isAcceptableOrUnknown(data['expirado']!, _expiradoMeta));
    } else if (isInserting) {
      context.missing(_expiradoMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
          _pendingSyncMeta,
          pendingSync.isAcceptableOrUnknown(
              data['pending_sync']!, _pendingSyncMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalApartadoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalApartadoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cliente_id'])!,
      piezaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pieza_id'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      fechaCreacion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_creacion'])!,
      fechaExpiracion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_expiracion']),
      nota: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nota']),
      piezaJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pieza_json'])!,
      expirado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}expirado'])!,
      pendingSync: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pending_sync'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $LocalApartadoTable createAlias(String alias) {
    return $LocalApartadoTable(attachedDatabase, alias);
  }
}

class LocalApartadoData extends DataClass
    implements Insertable<LocalApartadoData> {
  final int id;
  final int clienteId;
  final int piezaId;
  final int cantidad;
  final String estado;
  final DateTime fechaCreacion;
  final DateTime? fechaExpiracion;
  final String? nota;
  final String piezaJson;
  final bool expirado;
  final bool pendingSync;
  final DateTime lastUpdated;
  const LocalApartadoData(
      {required this.id,
      required this.clienteId,
      required this.piezaId,
      required this.cantidad,
      required this.estado,
      required this.fechaCreacion,
      this.fechaExpiracion,
      this.nota,
      required this.piezaJson,
      required this.expirado,
      required this.pendingSync,
      required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cliente_id'] = Variable<int>(clienteId);
    map['pieza_id'] = Variable<int>(piezaId);
    map['cantidad'] = Variable<int>(cantidad);
    map['estado'] = Variable<String>(estado);
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    if (!nullToAbsent || fechaExpiracion != null) {
      map['fecha_expiracion'] = Variable<DateTime>(fechaExpiracion);
    }
    if (!nullToAbsent || nota != null) {
      map['nota'] = Variable<String>(nota);
    }
    map['pieza_json'] = Variable<String>(piezaJson);
    map['expirado'] = Variable<bool>(expirado);
    map['pending_sync'] = Variable<bool>(pendingSync);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  LocalApartadoCompanion toCompanion(bool nullToAbsent) {
    return LocalApartadoCompanion(
      id: Value(id),
      clienteId: Value(clienteId),
      piezaId: Value(piezaId),
      cantidad: Value(cantidad),
      estado: Value(estado),
      fechaCreacion: Value(fechaCreacion),
      fechaExpiracion: fechaExpiracion == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaExpiracion),
      nota: nota == null && nullToAbsent ? const Value.absent() : Value(nota),
      piezaJson: Value(piezaJson),
      expirado: Value(expirado),
      pendingSync: Value(pendingSync),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory LocalApartadoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalApartadoData(
      id: serializer.fromJson<int>(json['id']),
      clienteId: serializer.fromJson<int>(json['clienteId']),
      piezaId: serializer.fromJson<int>(json['piezaId']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      estado: serializer.fromJson<String>(json['estado']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
      fechaExpiracion: serializer.fromJson<DateTime?>(json['fechaExpiracion']),
      nota: serializer.fromJson<String?>(json['nota']),
      piezaJson: serializer.fromJson<String>(json['piezaJson']),
      expirado: serializer.fromJson<bool>(json['expirado']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clienteId': serializer.toJson<int>(clienteId),
      'piezaId': serializer.toJson<int>(piezaId),
      'cantidad': serializer.toJson<int>(cantidad),
      'estado': serializer.toJson<String>(estado),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
      'fechaExpiracion': serializer.toJson<DateTime?>(fechaExpiracion),
      'nota': serializer.toJson<String?>(nota),
      'piezaJson': serializer.toJson<String>(piezaJson),
      'expirado': serializer.toJson<bool>(expirado),
      'pendingSync': serializer.toJson<bool>(pendingSync),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  LocalApartadoData copyWith(
          {int? id,
          int? clienteId,
          int? piezaId,
          int? cantidad,
          String? estado,
          DateTime? fechaCreacion,
          Value<DateTime?> fechaExpiracion = const Value.absent(),
          Value<String?> nota = const Value.absent(),
          String? piezaJson,
          bool? expirado,
          bool? pendingSync,
          DateTime? lastUpdated}) =>
      LocalApartadoData(
        id: id ?? this.id,
        clienteId: clienteId ?? this.clienteId,
        piezaId: piezaId ?? this.piezaId,
        cantidad: cantidad ?? this.cantidad,
        estado: estado ?? this.estado,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        fechaExpiracion: fechaExpiracion.present
            ? fechaExpiracion.value
            : this.fechaExpiracion,
        nota: nota.present ? nota.value : this.nota,
        piezaJson: piezaJson ?? this.piezaJson,
        expirado: expirado ?? this.expirado,
        pendingSync: pendingSync ?? this.pendingSync,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  LocalApartadoData copyWithCompanion(LocalApartadoCompanion data) {
    return LocalApartadoData(
      id: data.id.present ? data.id.value : this.id,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      piezaId: data.piezaId.present ? data.piezaId.value : this.piezaId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      estado: data.estado.present ? data.estado.value : this.estado,
      fechaCreacion: data.fechaCreacion.present
          ? data.fechaCreacion.value
          : this.fechaCreacion,
      fechaExpiracion: data.fechaExpiracion.present
          ? data.fechaExpiracion.value
          : this.fechaExpiracion,
      nota: data.nota.present ? data.nota.value : this.nota,
      piezaJson: data.piezaJson.present ? data.piezaJson.value : this.piezaJson,
      expirado: data.expirado.present ? data.expirado.value : this.expirado,
      pendingSync:
          data.pendingSync.present ? data.pendingSync.value : this.pendingSync,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalApartadoData(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('piezaId: $piezaId, ')
          ..write('cantidad: $cantidad, ')
          ..write('estado: $estado, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('fechaExpiracion: $fechaExpiracion, ')
          ..write('nota: $nota, ')
          ..write('piezaJson: $piezaJson, ')
          ..write('expirado: $expirado, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      clienteId,
      piezaId,
      cantidad,
      estado,
      fechaCreacion,
      fechaExpiracion,
      nota,
      piezaJson,
      expirado,
      pendingSync,
      lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalApartadoData &&
          other.id == this.id &&
          other.clienteId == this.clienteId &&
          other.piezaId == this.piezaId &&
          other.cantidad == this.cantidad &&
          other.estado == this.estado &&
          other.fechaCreacion == this.fechaCreacion &&
          other.fechaExpiracion == this.fechaExpiracion &&
          other.nota == this.nota &&
          other.piezaJson == this.piezaJson &&
          other.expirado == this.expirado &&
          other.pendingSync == this.pendingSync &&
          other.lastUpdated == this.lastUpdated);
}

class LocalApartadoCompanion extends UpdateCompanion<LocalApartadoData> {
  final Value<int> id;
  final Value<int> clienteId;
  final Value<int> piezaId;
  final Value<int> cantidad;
  final Value<String> estado;
  final Value<DateTime> fechaCreacion;
  final Value<DateTime?> fechaExpiracion;
  final Value<String?> nota;
  final Value<String> piezaJson;
  final Value<bool> expirado;
  final Value<bool> pendingSync;
  final Value<DateTime> lastUpdated;
  const LocalApartadoCompanion({
    this.id = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.piezaId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.estado = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
    this.fechaExpiracion = const Value.absent(),
    this.nota = const Value.absent(),
    this.piezaJson = const Value.absent(),
    this.expirado = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  LocalApartadoCompanion.insert({
    this.id = const Value.absent(),
    required int clienteId,
    required int piezaId,
    required int cantidad,
    required String estado,
    required DateTime fechaCreacion,
    this.fechaExpiracion = const Value.absent(),
    this.nota = const Value.absent(),
    required String piezaJson,
    required bool expirado,
    this.pendingSync = const Value.absent(),
    required DateTime lastUpdated,
  })  : clienteId = Value(clienteId),
        piezaId = Value(piezaId),
        cantidad = Value(cantidad),
        estado = Value(estado),
        fechaCreacion = Value(fechaCreacion),
        piezaJson = Value(piezaJson),
        expirado = Value(expirado),
        lastUpdated = Value(lastUpdated);
  static Insertable<LocalApartadoData> custom({
    Expression<int>? id,
    Expression<int>? clienteId,
    Expression<int>? piezaId,
    Expression<int>? cantidad,
    Expression<String>? estado,
    Expression<DateTime>? fechaCreacion,
    Expression<DateTime>? fechaExpiracion,
    Expression<String>? nota,
    Expression<String>? piezaJson,
    Expression<bool>? expirado,
    Expression<bool>? pendingSync,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clienteId != null) 'cliente_id': clienteId,
      if (piezaId != null) 'pieza_id': piezaId,
      if (cantidad != null) 'cantidad': cantidad,
      if (estado != null) 'estado': estado,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
      if (fechaExpiracion != null) 'fecha_expiracion': fechaExpiracion,
      if (nota != null) 'nota': nota,
      if (piezaJson != null) 'pieza_json': piezaJson,
      if (expirado != null) 'expirado': expirado,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  LocalApartadoCompanion copyWith(
      {Value<int>? id,
      Value<int>? clienteId,
      Value<int>? piezaId,
      Value<int>? cantidad,
      Value<String>? estado,
      Value<DateTime>? fechaCreacion,
      Value<DateTime?>? fechaExpiracion,
      Value<String?>? nota,
      Value<String>? piezaJson,
      Value<bool>? expirado,
      Value<bool>? pendingSync,
      Value<DateTime>? lastUpdated}) {
    return LocalApartadoCompanion(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      piezaId: piezaId ?? this.piezaId,
      cantidad: cantidad ?? this.cantidad,
      estado: estado ?? this.estado,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaExpiracion: fechaExpiracion ?? this.fechaExpiracion,
      nota: nota ?? this.nota,
      piezaJson: piezaJson ?? this.piezaJson,
      expirado: expirado ?? this.expirado,
      pendingSync: pendingSync ?? this.pendingSync,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (piezaId.present) {
      map['pieza_id'] = Variable<int>(piezaId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (fechaCreacion.present) {
      map['fecha_creacion'] = Variable<DateTime>(fechaCreacion.value);
    }
    if (fechaExpiracion.present) {
      map['fecha_expiracion'] = Variable<DateTime>(fechaExpiracion.value);
    }
    if (nota.present) {
      map['nota'] = Variable<String>(nota.value);
    }
    if (piezaJson.present) {
      map['pieza_json'] = Variable<String>(piezaJson.value);
    }
    if (expirado.present) {
      map['expirado'] = Variable<bool>(expirado.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalApartadoCompanion(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('piezaId: $piezaId, ')
          ..write('cantidad: $cantidad, ')
          ..write('estado: $estado, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('fechaExpiracion: $fechaExpiracion, ')
          ..write('nota: $nota, ')
          ..write('piezaJson: $piezaJson, ')
          ..write('expirado: $expirado, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
      'last_updated', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(Insertable<SyncMetadataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      lastUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_updated'])!,
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String key;
  final String value;
  final DateTime lastUpdated;
  const SyncMetadataData(
      {required this.key, required this.value, required this.lastUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      key: Value(key),
      value: Value(value),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory SyncMetadataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  SyncMetadataData copyWith(
          {String? key, String? value, DateTime? lastUpdated}) =>
      SyncMetadataData(
        key: key ?? this.key,
        value: value ?? this.value,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  SyncMetadataData copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.key == this.key &&
          other.value == this.value &&
          other.lastUpdated == this.lastUpdated);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String key,
    required String value,
    required DateTime lastUpdated,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        lastUpdated = Value(lastUpdated);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<DateTime>? lastUpdated,
      Value<int>? rowid}) {
    return SyncMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $LocalPartTable localPart = $LocalPartTable(this);
  late final $LocalApartadoTable localApartado = $LocalApartadoTable(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [localPart, localApartado, syncMetadata];
}

typedef $$LocalPartTableCreateCompanionBuilder = LocalPartCompanion Function({
  Value<int> id,
  required String codigo,
  required String nombre,
  Value<String?> descripcion,
  Value<String?> categoria,
  Value<String?> marca,
  required double precioCompra,
  required double precioVenta,
  required int stock,
  required int stockMinimo,
  Value<String?> ubicacion,
  required bool activo,
  required DateTime lastUpdated,
});
typedef $$LocalPartTableUpdateCompanionBuilder = LocalPartCompanion Function({
  Value<int> id,
  Value<String> codigo,
  Value<String> nombre,
  Value<String?> descripcion,
  Value<String?> categoria,
  Value<String?> marca,
  Value<double> precioCompra,
  Value<double> precioVenta,
  Value<int> stock,
  Value<int> stockMinimo,
  Value<String?> ubicacion,
  Value<bool> activo,
  Value<DateTime> lastUpdated,
});

class $$LocalPartTableFilterComposer
    extends Composer<_$LocalDatabase, $LocalPartTable> {
  $$LocalPartTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precioCompra => $composableBuilder(
      column: $table.precioCompra, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precioVenta => $composableBuilder(
      column: $table.precioVenta, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ubicacion => $composableBuilder(
      column: $table.ubicacion, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));
}

class $$LocalPartTableOrderingComposer
    extends Composer<_$LocalDatabase, $LocalPartTable> {
  $$LocalPartTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precioCompra => $composableBuilder(
      column: $table.precioCompra,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precioVenta => $composableBuilder(
      column: $table.precioVenta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ubicacion => $composableBuilder(
      column: $table.ubicacion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$LocalPartTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LocalPartTable> {
  $$LocalPartTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<double> get precioCompra => $composableBuilder(
      column: $table.precioCompra, builder: (column) => column);

  GeneratedColumn<double> get precioVenta => $composableBuilder(
      column: $table.precioVenta, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => column);

  GeneratedColumn<String> get ubicacion =>
      $composableBuilder(column: $table.ubicacion, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);
}

class $$LocalPartTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $LocalPartTable,
    LocalPartData,
    $$LocalPartTableFilterComposer,
    $$LocalPartTableOrderingComposer,
    $$LocalPartTableAnnotationComposer,
    $$LocalPartTableCreateCompanionBuilder,
    $$LocalPartTableUpdateCompanionBuilder,
    (
      LocalPartData,
      BaseReferences<_$LocalDatabase, $LocalPartTable, LocalPartData>
    ),
    LocalPartData,
    PrefetchHooks Function()> {
  $$LocalPartTableTableManager(_$LocalDatabase db, $LocalPartTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPartTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPartTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalPartTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<String?> marca = const Value.absent(),
            Value<double> precioCompra = const Value.absent(),
            Value<double> precioVenta = const Value.absent(),
            Value<int> stock = const Value.absent(),
            Value<int> stockMinimo = const Value.absent(),
            Value<String?> ubicacion = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              LocalPartCompanion(
            id: id,
            codigo: codigo,
            nombre: nombre,
            descripcion: descripcion,
            categoria: categoria,
            marca: marca,
            precioCompra: precioCompra,
            precioVenta: precioVenta,
            stock: stock,
            stockMinimo: stockMinimo,
            ubicacion: ubicacion,
            activo: activo,
            lastUpdated: lastUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String codigo,
            required String nombre,
            Value<String?> descripcion = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<String?> marca = const Value.absent(),
            required double precioCompra,
            required double precioVenta,
            required int stock,
            required int stockMinimo,
            Value<String?> ubicacion = const Value.absent(),
            required bool activo,
            required DateTime lastUpdated,
          }) =>
              LocalPartCompanion.insert(
            id: id,
            codigo: codigo,
            nombre: nombre,
            descripcion: descripcion,
            categoria: categoria,
            marca: marca,
            precioCompra: precioCompra,
            precioVenta: precioVenta,
            stock: stock,
            stockMinimo: stockMinimo,
            ubicacion: ubicacion,
            activo: activo,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalPartTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $LocalPartTable,
    LocalPartData,
    $$LocalPartTableFilterComposer,
    $$LocalPartTableOrderingComposer,
    $$LocalPartTableAnnotationComposer,
    $$LocalPartTableCreateCompanionBuilder,
    $$LocalPartTableUpdateCompanionBuilder,
    (
      LocalPartData,
      BaseReferences<_$LocalDatabase, $LocalPartTable, LocalPartData>
    ),
    LocalPartData,
    PrefetchHooks Function()>;
typedef $$LocalApartadoTableCreateCompanionBuilder = LocalApartadoCompanion
    Function({
  Value<int> id,
  required int clienteId,
  required int piezaId,
  required int cantidad,
  required String estado,
  required DateTime fechaCreacion,
  Value<DateTime?> fechaExpiracion,
  Value<String?> nota,
  required String piezaJson,
  required bool expirado,
  Value<bool> pendingSync,
  required DateTime lastUpdated,
});
typedef $$LocalApartadoTableUpdateCompanionBuilder = LocalApartadoCompanion
    Function({
  Value<int> id,
  Value<int> clienteId,
  Value<int> piezaId,
  Value<int> cantidad,
  Value<String> estado,
  Value<DateTime> fechaCreacion,
  Value<DateTime?> fechaExpiracion,
  Value<String?> nota,
  Value<String> piezaJson,
  Value<bool> expirado,
  Value<bool> pendingSync,
  Value<DateTime> lastUpdated,
});

class $$LocalApartadoTableFilterComposer
    extends Composer<_$LocalDatabase, $LocalApartadoTable> {
  $$LocalApartadoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get piezaId => $composableBuilder(
      column: $table.piezaId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
      column: $table.fechaCreacion, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaExpiracion => $composableBuilder(
      column: $table.fechaExpiracion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nota => $composableBuilder(
      column: $table.nota, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get piezaJson => $composableBuilder(
      column: $table.piezaJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get expirado => $composableBuilder(
      column: $table.expirado, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));
}

class $$LocalApartadoTableOrderingComposer
    extends Composer<_$LocalDatabase, $LocalApartadoTable> {
  $$LocalApartadoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clienteId => $composableBuilder(
      column: $table.clienteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get piezaId => $composableBuilder(
      column: $table.piezaId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaCreacion => $composableBuilder(
      column: $table.fechaCreacion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaExpiracion => $composableBuilder(
      column: $table.fechaExpiracion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nota => $composableBuilder(
      column: $table.nota, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get piezaJson => $composableBuilder(
      column: $table.piezaJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get expirado => $composableBuilder(
      column: $table.expirado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$LocalApartadoTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LocalApartadoTable> {
  $$LocalApartadoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get clienteId =>
      $composableBuilder(column: $table.clienteId, builder: (column) => column);

  GeneratedColumn<int> get piezaId =>
      $composableBuilder(column: $table.piezaId, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
      column: $table.fechaCreacion, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaExpiracion => $composableBuilder(
      column: $table.fechaExpiracion, builder: (column) => column);

  GeneratedColumn<String> get nota =>
      $composableBuilder(column: $table.nota, builder: (column) => column);

  GeneratedColumn<String> get piezaJson =>
      $composableBuilder(column: $table.piezaJson, builder: (column) => column);

  GeneratedColumn<bool> get expirado =>
      $composableBuilder(column: $table.expirado, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);
}

class $$LocalApartadoTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $LocalApartadoTable,
    LocalApartadoData,
    $$LocalApartadoTableFilterComposer,
    $$LocalApartadoTableOrderingComposer,
    $$LocalApartadoTableAnnotationComposer,
    $$LocalApartadoTableCreateCompanionBuilder,
    $$LocalApartadoTableUpdateCompanionBuilder,
    (
      LocalApartadoData,
      BaseReferences<_$LocalDatabase, $LocalApartadoTable, LocalApartadoData>
    ),
    LocalApartadoData,
    PrefetchHooks Function()> {
  $$LocalApartadoTableTableManager(
      _$LocalDatabase db, $LocalApartadoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalApartadoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalApartadoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalApartadoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> clienteId = const Value.absent(),
            Value<int> piezaId = const Value.absent(),
            Value<int> cantidad = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<DateTime> fechaCreacion = const Value.absent(),
            Value<DateTime?> fechaExpiracion = const Value.absent(),
            Value<String?> nota = const Value.absent(),
            Value<String> piezaJson = const Value.absent(),
            Value<bool> expirado = const Value.absent(),
            Value<bool> pendingSync = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
          }) =>
              LocalApartadoCompanion(
            id: id,
            clienteId: clienteId,
            piezaId: piezaId,
            cantidad: cantidad,
            estado: estado,
            fechaCreacion: fechaCreacion,
            fechaExpiracion: fechaExpiracion,
            nota: nota,
            piezaJson: piezaJson,
            expirado: expirado,
            pendingSync: pendingSync,
            lastUpdated: lastUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int clienteId,
            required int piezaId,
            required int cantidad,
            required String estado,
            required DateTime fechaCreacion,
            Value<DateTime?> fechaExpiracion = const Value.absent(),
            Value<String?> nota = const Value.absent(),
            required String piezaJson,
            required bool expirado,
            Value<bool> pendingSync = const Value.absent(),
            required DateTime lastUpdated,
          }) =>
              LocalApartadoCompanion.insert(
            id: id,
            clienteId: clienteId,
            piezaId: piezaId,
            cantidad: cantidad,
            estado: estado,
            fechaCreacion: fechaCreacion,
            fechaExpiracion: fechaExpiracion,
            nota: nota,
            piezaJson: piezaJson,
            expirado: expirado,
            pendingSync: pendingSync,
            lastUpdated: lastUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalApartadoTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $LocalApartadoTable,
    LocalApartadoData,
    $$LocalApartadoTableFilterComposer,
    $$LocalApartadoTableOrderingComposer,
    $$LocalApartadoTableAnnotationComposer,
    $$LocalApartadoTableCreateCompanionBuilder,
    $$LocalApartadoTableUpdateCompanionBuilder,
    (
      LocalApartadoData,
      BaseReferences<_$LocalDatabase, $LocalApartadoTable, LocalApartadoData>
    ),
    LocalApartadoData,
    PrefetchHooks Function()>;
typedef $$SyncMetadataTableCreateCompanionBuilder = SyncMetadataCompanion
    Function({
  required String key,
  required String value,
  required DateTime lastUpdated,
  Value<int> rowid,
});
typedef $$SyncMetadataTableUpdateCompanionBuilder = SyncMetadataCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> lastUpdated,
  Value<int> rowid,
});

class $$SyncMetadataTableFilterComposer
    extends Composer<_$LocalDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnFilters(column));
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$LocalDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => ColumnOrderings(column));
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
      column: $table.lastUpdated, builder: (column) => column);
}

class $$SyncMetadataTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $SyncMetadataTable,
    SyncMetadataData,
    $$SyncMetadataTableFilterComposer,
    $$SyncMetadataTableOrderingComposer,
    $$SyncMetadataTableAnnotationComposer,
    $$SyncMetadataTableCreateCompanionBuilder,
    $$SyncMetadataTableUpdateCompanionBuilder,
    (
      SyncMetadataData,
      BaseReferences<_$LocalDatabase, $SyncMetadataTable, SyncMetadataData>
    ),
    SyncMetadataData,
    PrefetchHooks Function()> {
  $$SyncMetadataTableTableManager(_$LocalDatabase db, $SyncMetadataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> lastUpdated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetadataCompanion(
            key: key,
            value: value,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            required DateTime lastUpdated,
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetadataCompanion.insert(
            key: key,
            value: value,
            lastUpdated: lastUpdated,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncMetadataTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $SyncMetadataTable,
    SyncMetadataData,
    $$SyncMetadataTableFilterComposer,
    $$SyncMetadataTableOrderingComposer,
    $$SyncMetadataTableAnnotationComposer,
    $$SyncMetadataTableCreateCompanionBuilder,
    $$SyncMetadataTableUpdateCompanionBuilder,
    (
      SyncMetadataData,
      BaseReferences<_$LocalDatabase, $SyncMetadataTable, SyncMetadataData>
    ),
    SyncMetadataData,
    PrefetchHooks Function()>;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$LocalPartTableTableManager get localPart =>
      $$LocalPartTableTableManager(_db, _db.localPart);
  $$LocalApartadoTableTableManager get localApartado =>
      $$LocalApartadoTableTableManager(_db, _db.localApartado);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
}
