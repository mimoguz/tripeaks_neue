import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class IO {
  const IO._();

  static Future<bool> write(String key, Map<String, dynamic> jsonObject) async {
    try {
      final file = await _getFile(key);
      await file.writeAsString(json.encode(jsonObject));
      _logger.d("Write $key to ${file.absolute.path}");
      return true;
    } catch (e) {
      _logger.e("Could not save $key.\n$e\n${e is Error ? e.stackTrace : null}");
      return false;
    }
  }

  static Future<T?> read<T>(String key, T Function(Map<String, dynamic>) reader) async {
    try {
      final file = await _getFile(key);
      final jsonText = await file.readAsString();
      _logger.d("Read $key from ${file.absolute.path}");
      return reader(json.decode(jsonText));
    } catch (e) {
      _logger.e("Could not read $key.\n$e\n${e is Error ? e.stackTrace : null}");
      return null;
    }
  }

  static Future<File> _getFile(String key) async {
    Directory dir;
    try {
      dir = await getApplicationSupportDirectory();
    } on MissingPlatformDirectoryException {
      dir = await getApplicationDocumentsDirectory();
    }
    return File("${dir.path}/tripeaks_neue.$key.json");
  }

  static final _logger = Logger();
}
