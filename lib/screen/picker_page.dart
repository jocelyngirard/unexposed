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
            MediaPickerDataState() => const Placeholder(color: Colors.blue),
            _ => Placeholder(
                color: Colors.green,
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<MediaPickerBloc>(context)
                          .add(FromGalleryMediaPickerEvent());
                    },
                    child: const Text("Load...")),
              ),
          },
        ),
      ),
    );
  }
}
