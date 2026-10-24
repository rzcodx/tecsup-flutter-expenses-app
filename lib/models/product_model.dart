class ProductModel {
  final int? id;
  final String name;
  final double price;
  final String date;
  final String type;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.date,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "price": price, "date": date, "type": type};
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"],
      name: map["name"],
      price: (map["price"] as num).toDouble(),
      date: map["date"],
      type: map["type"],
    );
  }
}
