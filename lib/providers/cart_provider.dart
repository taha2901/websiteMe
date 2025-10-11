// import 'package:flutter/foundation.dart';
// import 'package:websiteme/models/cart_item.dart';
// import 'package:websiteme/models/product.dart';

// class CartProvider with ChangeNotifier {
//   final List<CartItem> _items = [];

//   List<CartItem> get items => _items;
//   int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
//   double get subtotal => _items.fold(
//     0.0, 
//     (sum, item) => sum + item.totalPrice,
//   );
  
//   double get shipping => subtotal > 0 ? 10.0 : 0.0;
//   double get total => subtotal + shipping;

//   void addToCart(Product product) {
//     final existingIndex = _items.indexWhere(
//       (item) => item.product.id == product.id,
//     );

//     if (existingIndex >= 0) {
//       _items[existingIndex].quantity++;
//     } else {
//       _items.add(CartItem(product: product));
//     }
    
//     notifyListeners();
//   }

//   void removeFromCart(String productId) {
//     _items.removeWhere((item) => item.product.id == productId);
//     notifyListeners();
//   }

//   void updateQuantity(String productId, int quantity) {
//     final index = _items.indexWhere((item) => item.product.id == productId);
//     if (index >= 0) {
//       if (quantity <= 0) {
//         _items.removeAt(index);
//       } else {
//         _items[index].quantity = quantity;
//       }
//       notifyListeners();
//     }
//   }

//   void clearCart() {
//     _items.clear();
//     notifyListeners();
//   }
// }
