part of 'media_picker_bloc.dart';

sealed class MediaPickerState extends Equatable {
  const MediaPickerState();

  @override
  List<Object> get props => [];
}

final class EmptyMediaPickerState extends MediaPickerState {}

final class LoadingMediaPickerState extends MediaPickerState {}

final class MediaPickerDataState extends MediaPickerState {
  final List<MediaFile> mediaFiles;

  const MediaPickerDataState(this.mediaFiles);

  @override
  List<Object> get props => [...mediaFiles];
}

final class ErrorMediaPickerState extends MediaPickerState {}
