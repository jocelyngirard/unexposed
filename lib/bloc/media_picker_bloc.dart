import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_drag_and_drop/src/drop.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:unexposed_app/extension/dropitem.dart';
import 'package:unexposed_app/extension/xfile.dart';
import 'package:unexposed_app/model/media_file.dart';

part 'media_picker_event.dart';
part 'media_picker_state.dart';

class MediaPickerBloc extends Bloc<MediaPickerEvent, MediaPickerState> {

  final Set<MediaFile> medias = {};

  MediaPickerBloc() : super(EmptyMediaPickerState()) {
    on<FromGalleryMediaPickerEvent>((event, emit) async {
      emit(LoadingMediaPickerState());

      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultipleMedia();

      final mediaFiles = images.toMediaFiles();
      log(mediaFiles.toString(), name: "Adds from FromGalleryMediaPickerEvent");
      medias.addAll(mediaFiles);
      log(medias.toString(), name: "Medias");
      emit(MediaPickerDataState(medias.toList()));
    });

    on<DropZoneMediaPickerEvent>((event, emit) async {
      emit(LoadingMediaPickerState());

      final List<MediaFile?> mediaFilesFromItems = await Future.wait(
        event.dropEvent.session.items.map(
          (item) async {
            final name = await item.getName();
            final path = await item.getAbsolutePath();
            return name != null && path != null
                ? MediaFile(name: name, absolutePath: path)
                : null;
          },
        ),
      );

      final mediaFiles = mediaFilesFromItems.nonNulls.toList();
      log(mediaFiles.toString(), name: "Adds from DropZoneMediaPickerEvent");
      medias.addAll(mediaFiles);
      log(medias.toString(), name: "Medias");
      emit(MediaPickerDataState(medias.toList()));
    });
  }
}
