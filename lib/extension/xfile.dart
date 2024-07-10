import 'package:image_picker/image_picker.dart';
import 'package:unexposed_app/model/media_file.dart';

extension XFileToMediaFile on XFile {
  MediaFile toMediaFile() {
    return MediaFile(name: name, absolutePath: path);
  }
}

extension XFilesConverter on List<XFile> {
  List<MediaFile> toMediaFiles() {
    return map((xFile) => xFile.toMediaFile()).toList();
  }
}
