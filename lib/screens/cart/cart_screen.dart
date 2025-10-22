import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/logic/cubits/cart/cart_cubit.dart';
import 'package:websiteme/logic/cubits/cart/cart_states.dart';
import 'package:websiteme/models/cart_item.dart';
import '../../widgets/navbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCart();
  }

  double _calcSubtotal(List<CartItemModel> items) =>
      items.fold(0, (sum, i) => sum + i.total);
  double _calcShipping(double subtotal) => subtotal > 100 ? 0 : 9.99;
  double _calcTotal(double subtotal, double shipping) => subtotal + shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const Navbar(),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is CartLoaded) {
            final items = state.items;
            final subtotal = _calcSubtotal(items);
            final shipping = _calcShipping(subtotal);
            final total = _calcTotal(subtotal, shipping);

            return ResponsiveLayout(
              mobile: _buildMobileLayout(items, subtotal, shipping, total),
              tablet: _buildTabletLayout(items, subtotal, shipping, total),
              desktop: _buildDesktopLayout(items, subtotal, shipping, total),
            );
          }
          return const Center(child: Text('Your cart is empty.'));
        },
      ),
    );
  }

  Widget _buildDesktopLayout(
      List<CartItemModel> items, double subtotal, double shipping, double total) {
    return items.isEmpty
        ? _buildEmptyCart()
        : SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: const EdgeInsets.all(24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildCartItems(items)),
                    const SizedBox(width: 24),
                    Expanded(
                        flex: 1, child: _buildOrderSummary(subtotal, shipping, total)),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildTabletLayout(
      List<CartItemModel> items, double subtotal, double shipping, double total) {
    return items.isEmpty
        ? _buildEmptyCart()
        : SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildCartItems(items),
                    const SizedBox(height: 24),
                    _buildOrderSummary(subtotal, shipping, total),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildMobileLayout(
      List<CartItemModel> items, double subtotal, double shipping, double total) {
    return items.isEmpty
        ? _buildEmptyCart()
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCartItems(items, isCompact: true),
                const SizedBox(height: 24),
                _buildOrderSummary(subtotal, shipping, total),
              ],
            ),
          );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 120, color: AppColors.textLight),
            const SizedBox(height: 24),
            const Text('Your cart is empty',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Add some products to start shopping.',
                style: TextStyle(fontSize: 16, color: AppColors.textLight)),
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

  Widget _buildCartItems(List<CartItemModel> items, {bool isCompact = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Shopping Cart',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('${items.length} items',
            style: const TextStyle(fontSize: 16, color: AppColors.textLight)),
        const SizedBox(height: 24),
        ...items.map((item) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.image,
                          width: isCompact ? 70 : 90,
                          height: isCompact ? 70 : 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text('Qty: ${item.quantity}',
                                style: const TextStyle(
                                    color: AppColors.textLight, fontSize: 14)),
                            const SizedBox(height: 8),
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => context
                            .read<CartCubit>()
                            .removeFromCart(item.id),
                        icon: const Icon(Icons.delete_outline),
                        color: AppColors.error,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (item.quantity > 1) {
                                final updatedItem = CartItemModel(
                                  id: item.id,
                                  productId: item.productId,
                                  name: item.name,
                                  image: item.image,
                                  price: item.price,
                                  quantity: item.quantity - 1,
                                );
                                context.read<CartCubit>().addToCart(updatedItem);
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text('${item.quantity}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          IconButton(
                            onPressed: () {
                              final updatedItem = CartItemModel(
                                id: item.id,
                                productId: item.productId,
                                name: item.name,
                                image: item.image,
                                price: item.price,
                                quantity: item.quantity + 1,
                              );
                              context.read<CartCubit>().addToCart(updatedItem);
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                      Text(
                        '\$${item.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildOrderSummary(double subtotal, double shipping, double total) {
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
            _summaryRow('Total', '\$${total.toStringAsFixed(2)}', isTotal: true),
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
            color: valueColor ??
                (isTotal ? AppColors.primary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
