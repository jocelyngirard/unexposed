part of 'media_picker_bloc.dart';

sealed class MediaPickerEvent extends Equatable {
  const MediaPickerEvent();

  @override
  List<Object> get props => [];
}

final class AddMediaFromPickerEvent extends MediaPickerEvent {}

final class AddMediaFromDropZoneEvent extends MediaPickerEvent {
  final PerformDropEvent dropEvent;

  const AddMediaFromDropZoneEvent(this.dropEvent);

  @override
  List<Object> get props => [dropEvent];
}

final class RemoveMediaPickerEvent extends MediaPickerEvent {
  final MediaFile file;

  const RemoveMediaPickerEvent(this.file);

  @override
  List<Object> get props => [file];
}
