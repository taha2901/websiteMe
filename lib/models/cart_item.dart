
class CartItemModel {
  final String id; // document id in users/{uid}/cart/{id} -> here using productId is OK
  final String productId;
  final String name;
  final String image;
  final double price;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  // fromMap expects both the document data and the documentId (so we know the id)
  factory CartItemModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CartItemModel(
      id: documentId,
      productId: data['productId'] as String? ?? documentId,
      name: data['name'] as String? ?? '',
      image: data['image'] as String? ?? '',
      price: (data['price'] ?? 0).toDouble(),
      quantity: (data['quantity'] ?? 1) as int,
    );
  }

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? name,
    String? image,
    double? price,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
