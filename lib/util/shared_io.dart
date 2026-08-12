import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tripeaks_neue/util/export_result.dart';
import 'package:tripeaks_neue/util/import_result.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/util/get_file_picker.dart';

mixin SharedIo {
  Future<ExportResult> export({
    required BuildContext context,
    required Map<String, dynamic> jsonObject,
    required String suggestedName,
  }) async {
    saveLoop:
    while (true) {
      final path = await getFilePicker().pickSave(suggestedName);
      if (path == null) {
        // Operation was canceled by the user.
        return ExportCancelled();
      }
      _sharedLoger.d("File picked to save: $path");
      // XDG file chooser portal already handles overwrite problem
      if (await io.File(path).exists() && !io.Platform.isLinux) {
        if (context.mounted) {
          final dialogResult = await showAdaptiveDialog<OverwriteDialogResult>(
            context: context,
            builder: (ctx) => OverwriteDialog(fileName: io.File(path).uri.pathSegments.last),
            barrierDismissible: true,
            barrierColor: Colors.transparent,
          );
          handleDialogResult:
          switch (dialogResult) {
            case .cancel:
              return ExportCancelled();
            case .reselect:
              // Loop again
              continue saveLoop;
            case .overwrite:
              // Continue save operation
              break handleDialogResult;
            case _:
              return ExportCancelled();
          }
        } else {
          return ExportFailed("File exists & can't use the build context");
        }
      }

      try {
        await _writeExternal(jsonObject, path);
        return ExportSucceeded(path);
      } on Exception catch (e) {
        return ExportFailed(e.toString());
      }
    }
  }

  Future<ImportResult<T>> import<T>(T Function(Map<String, dynamic>) reader) async {
    final path = await getFilePicker().pickOpen();
    if (path == null) {
      return ImportCancelled();
    }
    _sharedLoger.d("File picked to open: $path");

    final String source;
    try {
      final file = XFile(path);
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

  Future<void> _writeExternal(Map<String, dynamic> jsonObject, String path) async {
    final output = json.encode(jsonObject);
    final fileData = Uint8List.fromList(output.codeUnits);
    const mimeType = 'text/plain';
    final XFile textFile = XFile.fromData(
      fileData,
      mimeType: mimeType,
      name: io.File(path).uri.pathSegments.last,
    );
    await textFile.saveTo(path);
  }

  final _sharedLoger = Logger();
}

// TODO: Strings
class OverwriteDialog extends StatelessWidget {
  const OverwriteDialog({super.key, required this.fileName});

  final String fileName;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return CommonDialog(
      title: Text("Overwrite Exiting File?"),
      content: Column(
        crossAxisAlignment: .start,
        spacing: 16,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Text(
                    "A file named \"$fileName\" already exists. Would you like to select another file or overwrite the existing file?",
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: .center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(OverwriteDialogResult.cancel),
                  child: Text("Cancel"),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(OverwriteDialogResult.reselect),
                  child: Text("Select a new file"),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .center,
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(OverwriteDialogResult.overwrite),
                  style: TextButton.styleFrom(foregroundColor: colours.error),
                  label: Text("Overwrite"),
                  icon: Icon(Icons.warning_rounded),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum OverwriteDialogResult { cancel, reselect, overwrite }
