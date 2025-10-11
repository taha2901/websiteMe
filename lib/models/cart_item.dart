import 'package:websiteme/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.finalPrice * quantity;
}


final List<CartItem> demoCart = [
  CartItem(product: demoProducts[0], quantity: 1),
  CartItem(product: demoProducts[3], quantity: 2),
];