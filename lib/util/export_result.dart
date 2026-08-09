sealed class ExportResult {
  const ExportResult();
}

final class ExportCancelled extends ExportResult {
  const ExportCancelled();
}

final class ExportFailed extends ExportResult {
  final String reason;
  const ExportFailed(this.reason);
}

final class ExportSucceeded extends ExportResult {
  final String path;
  const ExportSucceeded(this.path);
}
