import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/apartado.dart';
import '../../../core/services/api_service.dart';
import '../data/apartados_repository.dart';

final apartadosRepositoryProvider = Provider<ApartadosRepository>((ref) {
  return ApartadosRepository(ref.watch(apiServiceProvider));
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

  ApartadosQueryParams({
    this.page = 1,
    this.pageSize = 20,
    this.sortBy = 'id',
    this.sortOrder = 'asc',
  });

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
