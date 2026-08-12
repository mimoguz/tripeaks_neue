import 'dart:typed_data';

abstract interface class AbstractFilePicker {
  Future<String?> openFile();
  Future<String?> saveFile(String suggestedName, Uint8List data);
}
