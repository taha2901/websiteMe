
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/services/cart_service.dart';
import 'package:websiteme/logic/cubits/cart/cart_states.dart';
import 'package:websiteme/models/cart_item.dart';
import 'package:websiteme/models/product.dart';

class CartCubit extends Cubit<CartState> {
  final CartServices _cartService;
  final String _userId;

  CartCubit(this._cartService, this._userId) : super(CartInitial());

  Future<void> loadCart() async {
    if (_userId.isEmpty) {
      emit(CartLoaded([]));
      return;
    }

    try {
      emit(CartLoading());
      final items = await _cartService.getCartItems(_userId);
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addToCart(CartItemModel item) async {
    if (_userId.isEmpty) return;
    try {
      await _cartService.setCartItem(_userId, item);
      await loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeFromCart(String itemId) async {
    if (_userId.isEmpty) return;
    try {
      await _cartService.removeCartItem(_userId, itemId);
      await loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> clearCart() async {
    if (_userId.isEmpty) return;
    try {
      await _cartService.clearCart(_userId);
      await loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  /// الميثود اللي طلبتها: تعمل إضافة من Product object مباشرة
  Future<void> addToCartFromProduct(Product product, {int quantity = 1}) async {
    if (_userId.isEmpty) return;
    try {
      // جرب نقرأ الحالة الحالية ونشوف هل العنصر موجود
      final current = state;
      if (current is CartLoaded) {
        final existingIndex = current.items.indexWhere((i) => i.productId == product.id);
        if (existingIndex != -1) {
          // زود الكمية
          final existing = current.items[existingIndex];
          final updated = existing.copyWith(quantity: existing.quantity + quantity);
          await _cartService.setCartItem(_userId, updated);
          await loadCart();
          return;
        }
      }

      // لو مش موجود، أعمل عنصر جديد (نستخدم product.id كـ doc id)
      final newItem = CartItemModel(
        id: product.id, // تستخدم productId كـ document id عشان تبقى سهلة
        productId: product.id,
        name: product.name,
        image: product.image,
        price: product.finalPrice,
        quantity: quantity,
      );

      await _cartService.setCartItem(_userId, newItem);
      await loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
