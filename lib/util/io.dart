abstract interface class AbstractIO {
  Future<bool> write(String key, Map<String, dynamic> jsonObject);
  Future<T?> read<T>(String key, T Function(Map<String, dynamic>) reader);

  Future<bool> export(Map<String, dynamic> jsonObject);
  Future<T?> import<T>(T Function(Map<String, dynamic>) reader);
}
