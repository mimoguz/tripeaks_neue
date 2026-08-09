sealed class ImportResult<T> {
  const ImportResult();
}

final class ImportCancelled<T> extends ImportResult<T> {
  const ImportCancelled();
}

final class ImportIoFailed<T> extends ImportResult<T> {
  final String reason;
  const ImportIoFailed(this.reason);
}

final class ImportReaderFailed<T> extends ImportResult<T> {
  final String reason;
  const ImportReaderFailed(this.reason);
}

final class ImportSucceeded<T> extends ImportResult<T> {
  final T result;
  const ImportSucceeded(this.result);
}
