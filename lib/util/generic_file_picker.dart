import 'package:file_selector/file_selector.dart';
import 'package:tripeaks_neue/util/abstract_file_picker.dart';

final class GenericFilePicker implements AbstractFilePicker {
  const GenericFilePicker();

  @override
  Future<String?> pickOpen() async {
    final file = await openFile(acceptedTypeGroups: _typeGroups);
    return file?.path;
  }

  @override
  Future<String?> pickSave([String? suggestedName]) async {
    final file = await getSaveLocation(suggestedName: suggestedName, acceptedTypeGroups: _typeGroups);
    return file?.path;
  }

  static const _typeGroups = [
    XTypeGroup(
      label: "JSON files",
      extensions: <String>["json"],
      uniformTypeIdentifiers: <String>["public.json"],
    ),
    XTypeGroup(label: "All files", extensions: <String>[], uniformTypeIdentifiers: <String>[]),
  ];

  static const instance = GenericFilePicker();
}

AbstractFilePicker getFilePicker() => GenericFilePicker.instance;
