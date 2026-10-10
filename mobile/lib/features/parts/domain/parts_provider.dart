import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/part.dart';
import '../../../core/services/api_service.dart';
import '../data/parts_repository.dart';

final partsRepositoryProvider = Provider<PartsRepository>((ref) {
  return PartsRepository(ref.watch(apiServiceProvider));
});

final partsListProvider =
    FutureProvider.family<List<Part>, PartsQueryParams>((ref, params) async {
  final repository = ref.watch(partsRepositoryProvider);
  return repository.listParts(
    page: params.page,
    pageSize: params.pageSize,
    search: params.search,
    categoria: params.categoria,
    sortBy: params.sortBy,
    sortOrder: params.sortOrder,
  );
});

final partDetailProvider = FutureProvider.family<Part, int>((ref, id) async {
  final repository = ref.watch(partsRepositoryProvider);
  return repository.getPart(id);
});

class PartsQueryParams {
  final int page;
  final int pageSize;
  final String? search;
  final String? categoria;
  final String sortBy;
  final String sortOrder;

  PartsQueryParams({
    this.page = 1,
    this.pageSize = 20,
    this.search,
    this.categoria,
    this.sortBy = 'id',
    this.sortOrder = 'asc',
  });

  PartsQueryParams copyWith({
    int? page,
    int? pageSize,
    String? search,
    String? categoria,
    String? sortBy,
    String? sortOrder,
  }) {
    return PartsQueryParams(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      search: search ?? this.search,
      categoria: categoria ?? this.categoria,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
