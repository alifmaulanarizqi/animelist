class ExampleDto {
  final int id;
  final String title;
  final String image;
  final String imageType;

  const ExampleDto({
    this.id = 0,
    this.title = '',
    this.image = '',
    this.imageType = '',
  });

  @override
  String toString() {
    return 'ExampleDto{id;: $id, title: $title, image: $image}';
  }
}