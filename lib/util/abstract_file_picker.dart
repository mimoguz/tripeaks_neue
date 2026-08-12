abstract interface class AbstractFilePicker {
  Future<String?> pickOpen();
  Future<String?> pickSave([String? suggestedName]);
}
