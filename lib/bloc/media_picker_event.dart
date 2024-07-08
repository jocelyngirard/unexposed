part of 'media_picker_bloc.dart';

sealed class MediaPickerEvent extends Equatable {
  const MediaPickerEvent();

  @override
  List<Object> get props => [];
}

final class FromGalleryMediaPickerEvent extends MediaPickerEvent {}

final class DropZoneMediaPickerEvent extends MediaPickerEvent {}
