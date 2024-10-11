import 'package:equatable/equatable.dart';

class ThumbnailEntity extends Equatable {
  final String path;
  final String extension;

  const ThumbnailEntity({required this.path, required this.extension});

  @override
  List<Object?> get props => [path, extension];
}
