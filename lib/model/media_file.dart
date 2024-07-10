import 'package:equatable/equatable.dart';

class MediaFile extends Equatable {
  final String name;

  final String absolutePath;

  const MediaFile({
    required this.name,
    required this.absolutePath,
  });

  @override
  List<Object> get props => [name, absolutePath];
}
