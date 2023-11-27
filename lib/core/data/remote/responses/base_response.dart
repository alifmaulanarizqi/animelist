import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

///
/// {
///   "status": <bool>,
///   "code": <int>,
///   "message": <string>,
///   "data": <T>
/// }
///
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'pagination')
  final PaginationBaseResponse? pagination;
  @JsonKey(name: 'data')
  final T? data;

  BaseResponse({
    this.pagination,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
}

@JsonSerializable()
class PaginationBaseResponse<T> {
  @JsonKey(name: 'last_visible_page')
  final int? lastVisiblePage;
  @JsonKey(name: 'has_next_page')
  final bool? hasNextPage;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'items')
  final ItemPaginationBaseResponse? items;

  PaginationBaseResponse({
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
    this.items,
  });

  factory PaginationBaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$PaginationBaseResponseFromJson(json);
}

@JsonSerializable()
class ItemPaginationBaseResponse<T> {
  @JsonKey(name: 'count')
  final int? count;
  @JsonKey(name: 'total')
  final int? total;
  @JsonKey(name: 'per_page')
  final int? perPage;

  ItemPaginationBaseResponse({
    this.count,
    this.total,
    this.perPage,
  });

  factory ItemPaginationBaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$ItemPaginationBaseResponseFromJson(json);
}
