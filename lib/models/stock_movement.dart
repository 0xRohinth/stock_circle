class StockMovement {
  final int? id;
  final int productId;
  final String type; // "in" or "out"
  final int quantity;
  final String date;
  final String note;

  StockMovement({
    this.id,
    required this.productId,
    required this.type,
    required this.quantity,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'type': type,
      'quantity': quantity,
      'date': date,
      'notes': note,
    };
  }

  factory StockMovement.fromMap(Map<String, dynamic> map) {
    return StockMovement(
      id: map['id'],
      productId: map['productId'],
      type: map['type'],
      quantity: map['quantity'],
      date: map['date'],
      note: map['note'],
    );
  }
}
