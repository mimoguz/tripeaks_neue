import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:tripeaks_neue/util/export_result.dart';
import 'package:tripeaks_neue/util/import_result.dart';

mixin SharedIo {
  Future<ExportResult> export(Map<String, dynamic> jsonObject, [String? initialDirectory]) async {
    final FileSaveLocation? result = await getSaveLocation(
      initialDirectory: initialDirectory,
      suggestedName: _suggestedFileName,
      acceptedTypeGroups: [_typeGroup],
    );

    if (result == null) {
      // Operation was canceled by the user.
      return ExportCancelled();
    }

    final output = json.encode(jsonObject);
    final fileData = Uint8List.fromList(output.codeUnits);
    const mimeType = 'text/plain';
    final XFile textFile = XFile.fromData(fileData, mimeType: mimeType, name: _suggestedFileName);

    if (await io.File(result.path).exists()) {
      return ExportFileExists(result.path);
    }

    try {
      await textFile.saveTo(result.path);
      return ExportSucceeded(result.path);
    } on Exception catch (e) {
      return ExportFailed(e.toString());
    }
  }

  Future<ImportResult<T>> import<T>(T Function(Map<String, dynamic>) reader) async {
    const typeGroup = XTypeGroup(
      label: 'JSON files',
      extensions: <String>['json'],
      uniformTypeIdentifiers: <String>['public.json'],
    );

    final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null) {
      return ImportCancelled();
    }

    final String source;
    try {
      source = await file.readAsString();
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

  static const _typeGroup = XTypeGroup(
    label: 'JSON files',
    extensions: <String>['json'],
    uniformTypeIdentifiers: <String>['public.json'],
  );

  static const _suggestedFileName = 'tripeaksneue-data.json';
}
