import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_drag_and_drop/src/drop.dart';
import 'package:unexposed_app/widget/drop_zone.dart';

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

    on<DropZoneMediaPickerEvent>((event, emit) {
      emit(LoadingMediaPickerState());
      for (var item in event.dropEvent.session.items) {
        final reader = item.dataReader;
        if (reader != null) {
          for (var format in handledFormats) {
            if (reader.canProvide(format)) {
              reader.getFile(
                format,
                (file) {
                  log("${file.fileName}");
                },
              );
            }
          }
        }
      }
      emit(MediaPickerDataState());
    });
  }
}
