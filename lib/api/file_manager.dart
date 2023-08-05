import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
export 'package:file_picker/file_picker.dart' show FileType;

class FileManager {
  static Future<SingleFileResponse?> single({List<String> extensions = const [], FileType type = FileType.custom}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: type == FileType.custom ? extensions : null,
      type: type,
      allowMultiple: false,
    );
    if (result != null) {
      return _convert(result.files.single);
    }
    return null;
  }

  static Future<List<SingleFileResponse>?> multiple({List<String> extensions = const [], FileType type = FileType.custom}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: type == FileType.custom ? extensions : null,
      type: type,
      allowMultiple: true,
    );

    if (result != null) {
      List<SingleFileResponse> response = [];
      List<PlatformFile> files = result.files;
      for (PlatformFile file in files) {
        response.add(_convert(file));
      }
      return response;
    }

    return null;
  }

  static SingleFileResponse _convert(PlatformFile file) => SingleFileResponse(
        path: file.path!,
        extension: file.extension!,
        filename: file.name,
        size: file.size,
      );
}

class SingleFileResponse {
  String path;
  String filename;
  String extension;
  int size;

  SingleFileResponse({
    this.path = "",
    this.filename = "",
    this.extension = "",
    this.size = 0,
  });

  @override
  String toString() =>
      "{name: $filename, path: $path, extension: $extension, size: $size}";
}
