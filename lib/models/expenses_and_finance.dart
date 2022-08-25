class ExpensesAndFinance {
  final int id;
  final String key;
  final String? name;
  final double? price;
  final String? desc;
  ExpensesAndFinance(
      {required this.id,
      required this.key,
      required this.name,
      required this.price,
      this.desc});
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "key": key, "desc": desc, "price": price};
  }
}
