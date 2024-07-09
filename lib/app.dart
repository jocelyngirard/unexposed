import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unexposed_app/bloc/media_picker_bloc.dart';
import 'package:unexposed_app/screen/picker_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<MediaPickerBloc>(
          create: (BuildContext context) => MediaPickerBloc(),
        ),
      ], child: const PickerPage()),
    );
  }
}
