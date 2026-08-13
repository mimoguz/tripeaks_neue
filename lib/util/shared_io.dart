import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tripeaks_neue/util/export_result.dart';
import 'package:tripeaks_neue/util/import_result.dart';
import 'package:tripeaks_neue/util/generic_file_picker.dart';

mixin SharedIo {
  Future<ExportResult> export({
    required BuildContext context,
    required Map<String, dynamic> jsonObject,
    required String suggestedName,
  }) async {
    try {
      final data = Uint8List.fromList(json.encode(jsonObject).codeUnits);
      final result = await getFilePicker().saveFile(suggestedName, data);
      if (result == null) {
        return ExportCancelled();
      }
      return ExportSucceeded(result);
    } catch (e) {
      return ExportFailed(e.toString());
    }
  }

  Future<ImportResult<T>> import<T>(T Function(Map<String, dynamic>) reader) async {
    final String source;
    try {
      final src = await getFilePicker().openFile();
      if (src == null) {
        return ImportCancelled();
      }
      source = src;
    } on Exception catch (e) {
      return ImportIoFailed(e.toString());
    }

    try {
      final jsonObject = json.decode(source);
      final result = reader(jsonObject);
      return ImportSucceeded(result);
    } on Exception catch (e) {
      return ImportReaderFailed(e.toString());
    }
  }
}
