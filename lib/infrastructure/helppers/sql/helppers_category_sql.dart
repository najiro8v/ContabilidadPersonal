import 'package:contabilidad/domain/entities/models/models.dart';

class HelppersCategorySQL {
  static QueryOption? ObjectToQuery(Category? category, String db) {
    if (category == null) return null;

    return QueryOption();
  }
}
