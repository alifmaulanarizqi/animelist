// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleResponse _$ExampleResponseFromJson(Map<String, dynamic> json) =>
    ExampleResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['image'] as String?,
      json['imageType'] as String?,
    );

Map<String, dynamic> _$ExampleResponseToJson(ExampleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'imageType': instance.imageType,
    };
