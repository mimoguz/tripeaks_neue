import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tripeaks_neue/util/abstract_io.dart';
import 'package:tripeaks_neue/util/shared_io.dart';

final class LocalIO with SharedIo implements AbstractIO {
  LocalIO._();

  final _logger = Logger();

  @override
  Future<bool> write(String key, Map<String, dynamic> jsonObject) async {
    try {
      final file = await _getFile(key);
      if (file == null) {
        _logger.e("Could not get save directory");
        return false;
      }
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
      if (file == null) {
        _logger.e("Could not get save directory");
        return null;
      }
      final jsonText = await file.readAsString();
      _logger.d("Read $key from ${file.absolute.path}");
      return reader(json.decode(jsonText));
    } catch (e) {
      _logger.e("Could not read $key.\n$e\n${e is Error ? e.stackTrace : null}");
      return null;
    }
  }

  Future<File?> _getFile(String key) async {
    final dir =
        await _getApplicationSupportDirectory() ??
        await _getApplicationDocumentsDirectory() ??
        await _getSnapUserDataDirectory() ??
        await _getTemporaryDirectory();

    if (dir == null) {
      return null;
    }
    return File("${dir.path}/tripeaksneue.$key.json");
  }

  Future<Directory?> _getApplicationSupportDirectory() async {
    try {
      final dir = await getApplicationSupportDirectory();
      return dir;
    } catch (_) {
      return null;
    }
  }

  Future<Directory?> _getApplicationDocumentsDirectory() async {
    try {
      return await getApplicationDocumentsDirectory();
    } catch (_) {
      return null;
    }
  }

  Future<Directory?> _getSnapUserDataDirectory() {
    final snapUserData = Platform.environment["SNAP_USER_DATA"];
    if (snapUserData != null) {
      return Future.value(Directory(snapUserData));
    }
    return Future.value(null);
  }

  Future<Directory?> _getTemporaryDirectory() async {
    try {
      return await getTemporaryDirectory();
    } catch (_) {
      return null;
    }
  }

  static LocalIO? _instance;

  static LocalIO get instance {
    _instance ??= LocalIO._();
    return _instance!;
  }
}

AbstractIO getIO() => LocalIO.instance;
