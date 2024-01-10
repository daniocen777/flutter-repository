import 'package:educationapp/core/resources/media_resource.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          image: MediaResource.casualReading,
          title: 'Brand new curriculum',
          description:
              'This is the first online education plattaform designed by the '
              "world's top professors",
        );

  const PageContent.second()
      : this(
          image: MediaResource.casualLife,
          title: 'Brand a fun atmosphera',
          description:
              'This is the first online education plattaform designed by the '
              "world's top professors",
        );

  const PageContent.third()
      : this(
          image: MediaResource.casualMeditation,
          title: 'Easy to join the lesson',
          description:
              'This is the first online education plattaform designed by the '
              "world's top professors",
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
