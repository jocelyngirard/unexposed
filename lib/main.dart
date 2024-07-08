import 'dart:developer';
import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unexposed_app/app.dart';

void main() {
  runApp(const App());
}

void _incrementCounter() async {
  final ImagePicker picker = ImagePicker();
  final List<XFile> images = await picker.pickMultipleMedia();

  printExifOf(String path) async {
    final fileBytes = File(path).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);

    if (data.isEmpty) {
      print("No EXIF information found");
      return;
    }

    if (data.containsKey('JPEGThumbnail')) {
      print('File has JPEG thumbnail');
      data.remove('JPEGThumbnail');
    }
    if (data.containsKey('TIFFThumbnail')) {
      print('File has TIFF thumbnail');
      data.remove('TIFFThumbnail');
    }

    for (final entry in data.entries) {
      print("${entry.key}: ${entry.value}");
    }
  }

  for (final image in images) {
    await printExifOf(image.path);
    final Directory saveDir = await getTemporaryDirectory();
    var formatSplit = image.path.split(".");
    var format = formatSplit[formatSplit.length - 1];
    var targetPath = '${saveDir.absolute.path}/${image.name}_unexposed.$format';
    await FlutterImageCompress.compressAndGetFile(
      image.path,
      targetPath,
    );
    log("Compressed image saved to '$targetPath'");
  }
}
