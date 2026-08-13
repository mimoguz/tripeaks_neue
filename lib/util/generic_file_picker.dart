import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

// TODO: Strings
final class GenericFilePicker {
  const GenericFilePicker();

  Future<String?> openFile() async {
    final result = await FilePicker.pickFile(
      dialogTitle: "Pick File",
      allowedExtensions: ["json"],
      type: FileType.custom,
    );
    final bytes = await result?.readAsBytes();
    if (bytes == null) {
      return null;
    }
    return utf8.decoder.convert(bytes);
  }

  Future<String?> saveFile(String suggestedName, Uint8List data) async {
    final result = await FilePicker.saveFile(
      fileName: suggestedName,
      allowedExtensions: ["json"],
      bytes: data,
    );
    return result;
  }

  static const instance = GenericFilePicker();
}

GenericFilePicker getFilePicker() => GenericFilePicker.instance;
