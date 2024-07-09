import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:unexposed_app/bloc/media_picker_bloc.dart';

const imageFormats = [
  Formats.jpeg,
  Formats.heic,
  Formats.heif,
  Formats.png,
  Formats.webp,
];

const videoFormats = [
  Formats.mov,
  Formats.mp4,
  Formats.mpeg,
  Formats.avi,
  Formats.webm,
];

const handledFormats = [...imageFormats, ...videoFormats];

class DropZone extends StatelessWidget {
  final Widget child;

  const DropZone({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: handledFormats,
      hitTestBehavior: HitTestBehavior.opaque,
      onDropOver: (event) =>
          event.session.allowedOperations.contains(DropOperation.copy)
              ? DropOperation.copy
              : DropOperation.none,
      onDropEnter: (event) {},
      onDropLeave: (event) {},
      onPerformDrop: (event) async => BlocProvider.of<MediaPickerBloc>(context)
        ..add(DropZoneMediaPickerEvent(event)),
      child: child,
    );
  }
}
