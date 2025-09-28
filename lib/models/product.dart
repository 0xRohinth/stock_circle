class Product {
  int? id;
  String name;
  String category;
  String unit;
  double b2bPrice;
  double baseB2cPrice;
  int stockQty;
  String? notes;

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.b2bPrice,
    required this.baseB2cPrice,
    required this.stockQty,
    this.notes,
  });

  // Convert Product → Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'unit': unit,
      'b2bPrice': b2bPrice,
      'baseB2cPrice': baseB2cPrice,
      'stockQty': stockQty,
      'notes': notes,
    };
  }

  // Convert Map → Product (from SQLite)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      unit: map['unit'],
      b2bPrice: map['b2bPrice'],
      baseB2cPrice: map['baseB2cPrice'],
      stockQty: map['stockQty'],
      notes: map['notes'],
    );
  }
}
