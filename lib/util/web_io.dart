import "dart:convert";

import "package:logger/web.dart";
import "package:tripeaks_neue/util/io.dart";
import "package:web/web.dart";

final class WebIO implements AbstractIO {
  final _logger = Logger();

  @override
  Future<T?> read<T>(String key, T Function(Map<String, dynamic>) reader) {
    try {
      final jsonText = window.localStorage.getItem(key);
      final result = reader(json.decode(jsonText!));
      _logger.d("Read $key from local storage");
      return Future.value(result);
    } catch (e) {
      _logger.e("Could not read $key.\n$e\n${e is Error ? e.stackTrace : null}");
      return Future.value(null);
    }
  }

  @override
  Future<bool> write(String key, Map<String, dynamic> jsonObject) {
    try {
      window.localStorage.setItem(key, json.encode(jsonObject));
      _logger.d("Write $key to local storage");
      return Future.value(true);
    } catch (e) {
      _logger.e("Could not save $key.\n$e\n${e is Error ? e.stackTrace : null}");
      return Future.value(false);
    }
  }

  static WebIO? _instance;

  static WebIO get instance {
    _instance ??= WebIO();
    return _instance!;
  }
}

AbstractIO getIO() => WebIO.instance;
