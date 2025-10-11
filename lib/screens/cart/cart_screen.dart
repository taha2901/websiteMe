import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/footer.dart';
import '../../core/constants/app_colors.dart';
import '../../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _items = List.from(demoCart);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
  double get shipping => subtotal > 100 ? 0 : 9.99;
  double get total => subtotal + shipping;

  void _updateQuantity(String productId, int newQty) {
    setState(() {
      final item = _items.firstWhere((e) => e.product.id == productId);
      if (newQty <= 0) {
        _items.remove(item);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.product.name} removed from cart'),
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        item.quantity = newQty;
      }
    });
  }

  void _removeItem(String productId) {
    setState(() {
      final item = _items.firstWhere((e) => e.product.id == productId);
      _items.remove(item);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.product.name} removed from cart'),
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const Navbar(),
      body: Column(
        children: [
          Expanded(
            child: _items.isEmpty
                ? _buildEmptyCart(context)
                : SingleChildScrollView(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      padding: const EdgeInsets.all(24),
                      child: isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 2, child: _buildCartItems()),
                                const SizedBox(width: 24),
                                Expanded(flex: 1, child: _buildOrderSummary(context)),
                              ],
                            )
                          : Column(
                              children: [
                                _buildCartItems(),
                                const SizedBox(height: 24),
                                _buildOrderSummary(context),
                              ],
                            ),
                    ),
                  ),
          ),
          const Footer(),
        ],
      ),
    );
  }

  // 🛒 حالة السلة الفارغة
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 120, color: AppColors.textLight),
            const SizedBox(height: 24),
            const Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Add some products to start shopping.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.textLight),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/products'),
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('Continue Shopping'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🧾 عناصر السلة
  Widget _buildCartItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Shopping Cart',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('${_items.length} items',
            style: const TextStyle(fontSize: 16, color: AppColors.textLight)),
        const SizedBox(height: 24),

        // ✅ قائمة العناصر
        ..._items.map((item) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.product.image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 🧱 معلومات المنتج
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.product.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(item.product.category,
                            style: const TextStyle(
                                color: AppColors.textLight, fontSize: 14)),
                        const SizedBox(height: 8),
                        Text(
                          '\$${item.product.finalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 🔢 الكمية
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _updateQuantity(item.product.id, item.quantity - 1),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, anim) =>
                            ScaleTransition(scale: anim, child: child),
                        child: Text(
                          '${item.quantity}',
                          key: ValueKey(item.quantity),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _updateQuantity(item.product.id, item.quantity + 1),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),

                  const SizedBox(width: 8),

                  // 💰 السعر الإجمالي للمنتج
                  Text(
                    '\$${item.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  IconButton(
                    onPressed: () => _removeItem(item.product.id),
                    icon: const Icon(Icons.delete_outline),
                    color: AppColors.error,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // 📦 ملخص الطلب
  Widget _buildOrderSummary(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Summary',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            _summaryRow(
              'Shipping',
              shipping == 0 ? 'Free' : '\$${shipping.toStringAsFixed(2)}',
              valueColor: shipping == 0 ? AppColors.success : null,
            ),
            const Divider(height: 32),
            _summaryRow('Total', '\$${total.toStringAsFixed(2)}',
                isTotal: true),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/checkout'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Proceed to Checkout',
                      style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {bool isTotal = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            )),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? (isTotal ? AppColors.primary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
