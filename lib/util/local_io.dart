import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tripeaks_neue/util/io.dart';

final class LocalIO implements AbstractIO {
  LocalIO._();

  final _logger = Logger();

  @override
  Future<bool> write(String key, Map<String, dynamic> jsonObject) async {
    try {
      final file = await _getFile(key);
      await file.writeAsString(json.encode(jsonObject), flush: true);
      _logger.d("Write $key to ${file.absolute.path}");
      return true;
    } catch (e) {
      _logger.e("Could not save $key.\n$e\n${e is Error ? e.stackTrace : null}");
      return false;
    }
  }

  @override
  Future<T?> read<T>(String key, T Function(Map<String, dynamic>) reader) async {
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

  Future<File> _getFile(String key) async {
    Directory dir;
    try {
      dir = await getApplicationSupportDirectory();
    } on MissingPlatformDirectoryException {
      dir = await getApplicationDocumentsDirectory();
    }
    return File("${dir.path}/tripeaksneue.$key.json");
  }

  static LocalIO? _instance;

  static LocalIO get instance {
    _instance ??= LocalIO._();
    return _instance!;
  }
}

AbstractIO getIO() => LocalIO.instance;
