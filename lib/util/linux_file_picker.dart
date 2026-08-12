import 'dart:typed_data';

import 'package:tripeaks_neue/util/abstract_file_picker.dart';
import 'package:xdg_desktop_portal/xdg_desktop_portal.dart';

// TODO: Strings
final class LinuxFilePicker implements AbstractFilePicker {
  const LinuxFilePicker();

  @override
  Future<String?> pickOpen() async {
    final client = XdgDesktopPortalClient();
    try {
      // Invoke file chooser via Canonical's package wrapper
      final XdgFileChooserPortalOpenFileResult result = await client.fileChooser
          .openFile(
            title: "Select File to Import",
            multiple: false, // Set to true to allow multi-selection
            // Optional file filters
            filters: _filters,
          )
          .first;
      if (result.uris.isEmpty) {
        return null;
      }
      return result.uris.first.toString().replaceFirst(RegExp("file://"), "");
    } on Exception {
      return null;
    } finally {
      await client.close();
    }
  }

  @override
  Future<String?> pickSave([String? suggestedName]) async {
    final client = XdgDesktopPortalClient();
    try {
      // Invoke file chooser via Canonical's package wrapper
      final XdgFileChooserPortalSaveFileResult result = await client.fileChooser
          .saveFile(
            title: "Select File to Export",
            filters: _filters,
            currentFile: Uint8List.fromList((suggestedName ?? "").codeUnits),
          )
          .first;
      if (result.uris.isEmpty) {
        return null;
      }
      return result.uris.first.toString().replaceFirst(RegExp("file://"), "");
    } on Exception {
      return null;
    } finally {
      await client.close();
    }
  }

  static final _filters = [
    XdgFileChooserFilter("JSON files", [XdgFileChooserGlobPattern("*.json")]),
    XdgFileChooserFilter("All files", [XdgFileChooserGlobPattern("*")]),
  ];

  static const instance = LinuxFilePicker();
}

AbstractFilePicker getFilePicker() => LinuxFilePicker.instance;
