import 'package:flutter/material.dart';
import 'package:tripeaks_neue/util/export_result.dart';
import 'package:tripeaks_neue/util/import_result.dart';

abstract interface class AbstractIO {
  Future<bool> write(String key, Map<String, dynamic> jsonObject);
  Future<T?> read<T>(String key, T Function(Map<String, dynamic>) reader);

  Future<ExportResult> export({
    required BuildContext context,
    required Map<String, dynamic> jsonObject,
    required String suggestedName,
  });
  Future<ImportResult<T>> import<T>(T Function(Map<String, dynamic>) reader);
}
