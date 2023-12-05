import 'package:fms/src/example/data/remote/responses/example_response.dart';
import 'package:fms/src/example/domain/models/example_dto.dart';

extension PostResponseExt on ExampleResponse? {
  ExampleDto toDto() {
    return ExampleDto(
      id: this?.id ?? 0,
      title: this?.title ?? '',
      image: this?.image ?? '',
      imageType: this?.imageType ?? '',
    );
  }
}
