import 'package:contabilidad/domain/entities/models/models.dart';

class HelppersCategorySQL {
  static QueryOption? objectToQuery(dynamic model, String db) {
    if (model == null) return null;

    return QueryOption();
  }
}
