abstract class Repository {
  Future<List<Object?>> getAll();
  Future<Object?> find();
  Future<bool> remove();
  Future<Object?> add();
}
