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
    on<AddMediaFromPickerEvent>((event, emit) async {
      emit(LoadingMediaPickerState());

      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();

      final mediaFiles = images.toMediaFiles();
      log(mediaFiles.toString(), name: "Adds from FromGalleryMediaPickerEvent");
      emit(saveAndEmitMedias(mediaFiles));
    });

    on<AddMediaFromDropZoneEvent>((event, emit) async {
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
      emit(saveAndEmitMedias(mediaFiles));
    });

    on<RemoveMediaPickerEvent>((event, emit) async {
      emit(saveAndEmitMedias([event.file], remove: true));
    });
  }

  MediaPickerState saveAndEmitMedias(
    List<MediaFile> mediaFiles, {
    bool remove = false,
  }) {
    if (remove) {
      medias.removeAll(mediaFiles);
    } else {
      medias.addAll(mediaFiles);
    }
    log(medias.toString(), name: "Medias");
    if (medias.isEmpty) {
      return EmptyMediaPickerState();
    } else {
      return MediaPickerDataState(medias.toList());
    }
  }
}
