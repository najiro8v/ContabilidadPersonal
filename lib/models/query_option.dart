import 'package:flutter/material.dart';

class QueryOption {
  QueryOption({
    this.table,
    this.columns,
    this.distinct,
    this.groupBy,
    this.having,
    this.limit,
    this.offset,
    this.orderBy,
    this.where,
    this.whereArgs,
  });
  String? table = "";
  List<String>? columns = [];
  bool? distinct = false;
  String? groupBy;
  String? having;
  int? limit = 0;
  int? offset = 0;
  String? orderBy;
  String? where;
  List<Object>? whereArgs = [];
}
