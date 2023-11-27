class BaseResponseDto<T> {
  final List<T> data;
  final PaginationBaseResponseDto? pagination;

  const BaseResponseDto({
    required this.data,
    this.pagination,
  });

  @override
  String toString() {
    return 'BaseResponseDto{data: $data, pagination: $pagination}';
  }
}

class PaginationBaseResponseDto {
  final int lastVisiblePage;
  final bool hasNextPage;
  final int currentPage;
  final ItemPaginationBaseResponseDto? items;

  const PaginationBaseResponseDto({
    this.lastVisiblePage = 0,
    this.hasNextPage = false,
    this.currentPage = 0,
    this.items,
  });

  @override
  String toString() {
    return 'PaginationBaseResponseDto{lastVisiblePage: $lastVisiblePage, hasNextPage: $hasNextPage, currentPage: $currentPage, items: $items}';
  }
}

class ItemPaginationBaseResponseDto<T> {
  final int count;
  final int total;
  final int perPage;

  const ItemPaginationBaseResponseDto({
    this.count = 0,
    this.total = 0,
    this.perPage = 0,
  });

  @override
  String toString() {
    return 'ItemPaginationBaseResponseDto{count: $count, total: $total, perPage: $perPage}';
  }
}