typedef JsonObject = Map<String, dynamic>;

extension JsonObjectOps on JsonObject {
  DateTime readDate(String key) => DateTime.parse(this[key] as String);
  T read<T>(String key) => this[key] as T;
  T readDefault<T>(String key, T defaultValue) => containsKey(key) ? this[key] as T : defaultValue;
}
