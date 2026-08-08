import 'dart:convert';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:logger/logger.dart';

const _typeGroup = XTypeGroup(
  label: 'JSON files',
  extensions: <String>['json'],
  uniformTypeIdentifiers: <String>['public.json'],
);

const _suggestedFileName = 'tripeaksneue-data.json';

Future<bool> export(Map<String, dynamic> jsonObject, [Logger? logger]) async {
  final FileSaveLocation? result = await getSaveLocation(
    suggestedName: _suggestedFileName,
    acceptedTypeGroups: [_typeGroup],
  );

  if (result == null) {
    // Operation was canceled by the user.
    return false;
  }

  final output = json.encode(jsonObject);
  final fileData = Uint8List.fromList(output.codeUnits);
  const mimeType = 'text/plain';
  final XFile textFile = XFile.fromData(fileData, mimeType: mimeType, name: _suggestedFileName);

  try {
    // TODO: <Important!> Overwrite confirmation
    await textFile.saveTo(result.path);
    return true;
  } on Exception catch (e) {
    logger?.d(e.toString());
    return false;
  }
}

Future<T?> import<T>(T Function(Map<String, dynamic>) reader, [Logger? logger]) async {
  const typeGroup = XTypeGroup(
    label: 'JSON files',
    extensions: <String>['json'],
    uniformTypeIdentifiers: <String>['public.json'],
  );

  final file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
  if (file == null) {
    return null;
  }
  logger?.d(await file.readAsString());
  return null;
}
