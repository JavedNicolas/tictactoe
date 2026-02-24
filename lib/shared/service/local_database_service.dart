abstract interface class LocalDatabaseService {
  void init();
  Future<Object?> read({required String key});
  Future<void> write({required String key, required Object value});
}
