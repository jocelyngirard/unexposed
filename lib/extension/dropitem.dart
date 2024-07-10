import 'dart:async';

import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:unexposed_app/widget/drop_zone.dart';

extension AsyncDataReader on DropItem {
  Future<String?> getName() async {
    final reader = dataReader;
    if (reader != null) {
      final bool itemHandled = handledFormats.fold(
        false,
        (value, element) => value || reader.canProvide(element),
      );
      if (itemHandled) {
        return await reader.getSuggestedName();
      }
    }
    return null;
  }

  Future<String?> getAbsolutePath() async {
    final completer = Completer<String?>();
    final reader = dataReader;
    if (reader != null) {
      final bool itemHandled = handledFormats.fold(
        false,
        (value, element) => value || reader.canProvide(element),
      );
      if (itemHandled) {
        reader.getValue(
          Formats.fileUri,
          (uri) => completer.complete(
            uri != null ? Uri.decodeFull(uri.path) : null,
          ),
          onError: (error) => completer.completeError(error),
        );
      } else {
        completer.complete(null);
      }
    } else {
      completer.complete(null);
    }
    return completer.future;
  }
}
