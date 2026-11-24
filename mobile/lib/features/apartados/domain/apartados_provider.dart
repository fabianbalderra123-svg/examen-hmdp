import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/apartado.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/services/local_database.dart';
import '../data/apartados_repository.dart';

final apartadosRepositoryProvider = Provider<ApartadosRepository>((ref) {
  return ApartadosRepository(ref.watch(apiServiceProvider), LocalDatabase.instance);
});

final apartadosListProvider =
    FutureProvider.family<List<Apartado>, ApartadosQueryParams>((ref, params) async {
  final repository = ref.watch(apartadosRepositoryProvider);
  return repository.listApartados(
    page: params.page,
    pageSize: params.pageSize,
    sortBy: params.sortBy,
    sortOrder: params.sortOrder,
  );
});

final apartadoDetailProvider = FutureProvider.family<Apartado, int>((ref, id) async {
  final repository = ref.watch(apartadosRepositoryProvider);
  return repository.getApartado(id);
});

class ApartadosQueryParams {
  final int page;
  final int pageSize;
  final String sortBy;
  final String sortOrder;

  const ApartadosQueryParams({
    this.page = 1,
    this.pageSize = 50,
    this.sortBy = 'fechaCreacion',
    this.sortOrder = 'desc',
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApartadosQueryParams &&
          page == other.page &&
          pageSize == other.pageSize &&
          sortBy == other.sortBy &&
          sortOrder == other.sortOrder;

  @override
  int get hashCode => Object.hash(page, pageSize, sortBy, sortOrder);

  ApartadosQueryParams copyWith({
    int? page,
    int? pageSize,
    String? sortBy,
    String? sortOrder,
  }) {
    return ApartadosQueryParams(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
