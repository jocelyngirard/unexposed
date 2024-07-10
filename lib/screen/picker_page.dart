import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unexposed_app/bloc/media_picker_bloc.dart';
import 'package:unexposed_app/widget/drop_zone.dart';

class PickerPage extends StatelessWidget {
  const PickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DropZone(
        child: BlocBuilder<MediaPickerBloc, MediaPickerState>(
          builder: (context, state) => switch (state) {
            LoadingMediaPickerState() => const CircularProgressIndicator(),
            MediaPickerDataState() => ListView.separated(
                itemBuilder: (context, index) {
                  var file = state.mediaFiles[index];
                  return ListTile(
                    title: Text(file.name),
                    subtitle: Text(file.absolutePath),
                    leading: AspectRatio(
                      aspectRatio: 1,
                      child: Image.file(
                        File(file.absolutePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => BlocProvider.of<MediaPickerBloc>(context)
                        ..add(RemoveMediaPickerEvent(file)),
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
                itemCount: state.mediaFiles.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            _ => SizedBox.expand(
                child: Placeholder(
                  color: Colors.green,
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<MediaPickerBloc>(context)
                              .add(AddMediaFromPickerEvent());
                        },
                        child: const Text("Load...")),
                  ),
                ),
              ),
          },
        ),
      ),
    );
  }
}
