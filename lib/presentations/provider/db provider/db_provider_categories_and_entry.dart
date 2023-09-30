import 'package:contabilidad/domain/entities/entities.dart';
import 'package:contabilidad/infrastructure/repository/controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//#Finance Region
final myCategoryEditProvider =
    StateProvider<Category>((ref) => Category(name: "", key: null));
final categorySelectionProvider = StateProvider<int?>((ref) => null);
final entrySelectionProvider = StateProvider<int?>((ref) => null);

final categoryProviderList = FutureProvider<List<Category>>((ref) async {
  final category = CategoryController();
  return category.find();
});

final entryProviderList = FutureProvider<List<Entry>>((ref) async {
  final idCategory = ref.watch(categorySelectionProvider);
  final entry = EntryController();
  return idCategory == null
      ? entry.find()
      : entry.findByCategory(id: [idCategory]);
});

final entryValueProviderState =
    FutureProvider.family<ValueEntry, ValueEntry>((ref, entity) async {
  final valueEntry = ValueEntryController();
  return valueEntry.insert(entity: entity);
});

//#End Finance Region

// Category list Region
final categoryProvider =
    StateNotifierProvider<CategoryState, List<Category>>((ref) {
  return CategoryState();
});

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

  editData(Category category) async {
    final newState = [...state];
    final newCategory = await categoryData.findUpdate(entity: category);
    state = newState
        .map((element) => element.id == newCategory.id ? newCategory : element)
        .toList();
  }

  stateData(Category category) async {
    final newState = [...state];
    final newCategory = await categoryData.findUpdate(entity: category);
    state = newState
        .map((element) => element.id == newCategory.id ? newCategory : element)
        .toList();
  }

  bool isEnableList() {
    final list = state.where((element) => element.enable!);
    return list.isEmpty;
  }
}

//#End Category list Region

// Entry list Region

final entryProvider = StateNotifierProvider<EntryState, List<Entry>>((ref) {
  return EntryState();
});

class EntryState extends StateNotifier<List<Entry>> {
  final entryData = EntryController();
  int? id;
  EntryState() : super([]) {
    getData();
  }

  getData() async {
    final list = id == null
        ? await entryData.find()
        : await entryData.findByCategory(id: [id!]);
    state = list;
  }

  filterData({Entry? entry}) async {
    final list = id == null
        ? await entryData.find()
        : await entryData.findByCategory(id: [id!]);
    state = list;
  }

  changeCategory(int id) {
    this.id = id;
    getData();
  }

  addData(Entry entry) async {
    final newEntry = await entryData.insert(entity: entry);
    state = [...state, newEntry];
  }

  editData(Entry entry) async {
    final newState = [...state];
    final newCategory = await entryData.findUpdate(entity: entry);
    state = newState
        .map((element) => element.id == newCategory.id ? newCategory : element)
        .toList();
  }

  removeData(int id) async {
    final newState = [...state];
    final newCategory = await entryData.remove(id: id);
    if (newCategory) {
      newState.removeWhere((element) => element.id! == id);
      state = [...newState];
    }
  }
}

//#End Entry list Region

final entryIdProvider = StateProvider((ref) => 1);
