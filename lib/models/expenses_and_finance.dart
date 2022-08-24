class ExpensesAndFinance {
  final int id;
  final String key;
  final String? name;
  final double? price;
  final String? descri;
  ExpensesAndFinance(
      {required this.id,
      required this.key,
      required this.name,
      required this.price,
      this.descri});
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "key": key, "desc": descri, "price": price};
  }
}
