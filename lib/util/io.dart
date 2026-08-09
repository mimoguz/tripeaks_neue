import 'package:tripeaks_neue/util/export_result.dart';
import 'package:tripeaks_neue/util/import_result.dart';

abstract interface class AbstractIO {
  Future<bool> write(String key, Map<String, dynamic> jsonObject);
  Future<T?> read<T>(String key, T Function(Map<String, dynamic>) reader);

  Future<ExportResult> export(Map<String, dynamic> jsonObject, [String? initialDirectory]);
  Future<ImportResult<T>> import<T>(T Function(Map<String, dynamic>) reader);
  Future<void> writeExternal(Map<String, dynamic> jsonObject, String path);
}
