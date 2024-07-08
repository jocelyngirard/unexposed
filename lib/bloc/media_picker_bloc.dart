import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'media_picker_event.dart';
part 'media_picker_state.dart';

class MediaPickerBloc extends Bloc<MediaPickerEvent, MediaPickerState> {
  MediaPickerBloc() : super(EmptyMediaPickerState()) {
    on<FromGalleryMediaPickerEvent>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      emit(LoadingMediaPickerState());
      final List<XFile> images = await picker.pickMultipleMedia();
      emit(MediaPickerDataState());
    });

    on<DropZoneMediaPickerEvent>((event, emit) {});
  }
}
