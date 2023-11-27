// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      pagination: json['pagination'] == null
          ? null
          : PaginationBaseResponse<dynamic>.fromJson(
              json['pagination'] as Map<String, dynamic>, (value) => value),
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

PaginationBaseResponse<T> _$PaginationBaseResponseFromJson<T>(
        Map<String, dynamic> json) =>
    PaginationBaseResponse<T>(
      lastVisiblePage: json['last_visible_page'] as int?,
      hasNextPage: json['has_next_page'] as bool?,
      currentPage: json['current_page'] as int?,
      items: json['items'] == null
          ? null
          : ItemPaginationBaseResponse<dynamic>.fromJson(
              json['items'] as Map<String, dynamic>, (value) => value),
    );

Map<String, dynamic> _$PaginationBaseResponseToJson<T>(
        PaginationBaseResponse<T> instance) =>
    <String, dynamic>{
      'last_visible_page': instance.lastVisiblePage,
      'has_next_page': instance.hasNextPage,
      'current_page': instance.currentPage,
      'items': instance.items,
    };

ItemPaginationBaseResponse<T> _$ItemPaginationBaseResponseFromJson<T>(
        Map<String, dynamic> json) =>
    ItemPaginationBaseResponse<T>(
      count: json['count'] as int?,
      total: json['total'] as int?,
      perPage: json['per_page'] as int?,
    );

Map<String, dynamic> _$ItemPaginationBaseResponseToJson<T>(
        ItemPaginationBaseResponse<T> instance) =>
    <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
      'per_page': instance.perPage,
    };
