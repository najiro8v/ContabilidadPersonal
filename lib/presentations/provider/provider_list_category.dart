import 'package:contabilidad/domain/entities/models/models.dart';
import 'package:contabilidad/infrastructure/repository/controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final collapseListProvider = StateProvider((ref) => false);
final collaps1eListProvider = StateProvider((ref) => false);
final checktypeProvider = StateProvider((ref) => false);

final valueEntryProvider =
    StateNotifierProvider<ValueEntryState, List<ValueEntry>>((ref) {
  return ValueEntryState();
});

class ValueEntryState extends StateNotifier<List<ValueEntry>> {
  final valueEntryData = ValueEntryController();
  int? id;
  List<int>? idList;
  ValueEntryState() : super([]) {
    getData();
  }

  getData() async {
    List<int> ids = [];
    if (idList != null) {
      ids.addAll(idList!);
    }
    if (id != null) {
      ids.add(id!);
    }

    final list = id == null && idList == null
        ? await valueEntryData.find()
        : await valueEntryData.findByEntry(id: ids);
    state = list;
  }

  addId(int id) {
    idList ??= [id];
    if (idList!.contains(id)) return;
    idList!.add(id);
  }

  removeId(int id) {
    if (idList == null) return;
    if (!(idList!.contains(id))) return;
    idList!.removeWhere((element) => element == id);
  }

  cleanId() {
    idList = null;
    id = null;
  }

  changeCategory(int id) {
    this.id = id;
    getData();
  }

  addData(ValueEntry valueEntry) async {
    final newValueEntry = await valueEntryData.insert(entity: valueEntry);
    state = [...state, newValueEntry];
  }

  editData(ValueEntry valueEntry) async {
    final newState = [...state];
    final newValueEntry = await valueEntryData.findUpdate(entity: valueEntry);
    state = newState
        .map((element) =>
            element.id == newValueEntry.id ? newValueEntry : element)
        .toList();
  }

  removeData(int id) async {
    final newState = [...state];
    final newValueEntry = await valueEntryData.remove(id: id);
    if (newValueEntry) {
      newState.removeWhere((element) => element.id! == id);
      state = [...newState];
    }
  }
}
