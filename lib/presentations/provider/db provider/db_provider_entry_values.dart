import 'package:contabilidad/domain/entities/models/models.dart';

import 'package:contabilidad/infrastructure/repository/controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryProvider1 = FutureProvider<List<Category>>((ref) async {
  final category = CategoryController();
  return category.find();
});

final categoryProvider =
    StateNotifierProvider<CategoryState, List<Category>>((ref) {
  return CategoryState();
});
final entryProvider = FutureProvider<List<Entry>>((ref) async {
  final id = ref.watch(entryIdProvider);
  final entry = EntryController();
  return entry.findByCategory(id: [id]);
});

class EntryState extends StateNotifier<List<Entry>> {
  final entrySQL = EntryController();
  int? id;
  EntryState() : super([]) {
    getData();
  }

  getData() async {
    final list = id == null
        ? await entrySQL.find()
        : await entrySQL.findByCategory(id: [id!]);
    state = list;
  }

  changeCategory(int id) {
    this.id = id;
    getData();
  }

  addData(Entry entry) {}
}

class CategoryState extends StateNotifier<List<Category>> {
  final categoryData = CategoryController();
  int id = 1;
  CategoryState() : super([]);

  getData() async {
    final list = await categoryData.find();
    state = list;
  }

  addData(Category category) async {
    final newCategory = await categoryData.insert(entity: category);
    state = [...state, newCategory];
  }
}

final entryIdProvider = StateProvider((ref) => 1);
