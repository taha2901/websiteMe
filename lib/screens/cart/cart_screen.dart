
// import 'package:flutter/material.dart';
// import '../../widgets/navbar.dart';
// import '../../widgets/footer.dart';
// import '../../core/constants/app_colors.dart';
// import '../../models/product.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   // Mock cart data
//   final List<_CartItem> _items = [
//     _CartItem(
//       product: Product(
//         id: '1',
//         name: 'Wireless Headphones',
//         category: 'Electronics',
//         image: 'https://via.placeholder.com/150',
//         price: 79.99,
//        discountPrice: 0,
//         rating: 4.2,
//         reviewsCount: 89,
//         description: 'Running shoes for men',
//         stock: 20,
//         features: ['Lightweight', 'Comfortable', 'Durable'],
//         specifications: {'Size': '10', 'Color': 'Black', 'Material': 'Leather'},
//         images: [
//           'https://via.placeholder.com/150',
//           'https://via.placeholder.com/150',
//         ],
//       ),
//       quantity: 1,
//     ),
//     _CartItem(
//       product: Product(
//         id: '2',
//         name: 'Running Shoes',
//         category: 'Sportswear',
//         image: 'https://via.placeholder.com/150',
//         price: 59.99,
//         discountPrice: 0,
//         rating: 4.2,
//         reviewsCount: 89,
//         description: 'Running shoes for men',
//         stock: 20,
//         features: ['Lightweight', 'Comfortable', 'Durable'],
//         specifications: {'Size': '10', 'Color': 'Black', 'Material': 'Leather'},
//         images: [
//           'https://via.placeholder.com/150',
//           'https://via.placeholder.com/150',
//         ],
//       ),
//       quantity: 2,
//     ),
//   ];

//   double get subtotal => _items.fold(
//     0,
//     (sum, item) => sum + item.product.finalPrice * item.quantity,
//   );
//   double get shipping => subtotal > 100 ? 0 : 9.99;
//   double get total => subtotal + shipping;

//   void _updateQuantity(String productId, int newQty) {
//     setState(() {
//       final item = _items.firstWhere((e) => e.product.id == productId);
//       if (newQty <= 0) {
//         _items.remove(item);
//       } else {
//         item.quantity = newQty;
//       }
//     });
//   }

//   void _removeItem(String productId) {
//     setState(() => _items.removeWhere((e) => e.product.id == productId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = MediaQuery.of(context).size.width >= 900;

//     return Scaffold(
//       appBar: const Navbar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: _items.isEmpty
//                 ? _buildEmptyCart(context)
//                 : SingleChildScrollView(
//                     child: Container(
//                       constraints: const BoxConstraints(maxWidth: 1200),
//                       padding: const EdgeInsets.all(24),
//                       child: isDesktop
//                           ? Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(flex: 2, child: _buildCartItems()),
//                                 const SizedBox(width: 24),
//                                 Expanded(
//                                   flex: 1,
//                                   child: _buildOrderSummary(context),
//                                 ),
//                               ],
//                             )
//                           : Column(
//                               children: [
//                                 _buildCartItems(),
//                                 const SizedBox(height: 24),
//                                 _buildOrderSummary(context),
//                               ],
//                             ),
//                     ),
//                   ),
//           ),
//           const Footer(),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyCart(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_cart_outlined,
//             size: 120,
//             color: AppColors.textLight,
//           ),
//           const SizedBox(height: 24),
//           const Text(
//             'Your cart is empty',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'Add some products to get started',
//             style: TextStyle(fontSize: 16, color: AppColors.textLight),
//           ),
//           const SizedBox(height: 32),
//           ElevatedButton(
//             onPressed: () => Navigator.pushNamed(context, '/products'),
//             child: const Text('Continue Shopping'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCartItems() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Shopping Cart',
//           style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           '${_items.length} items',
//           style: const TextStyle(fontSize: 16, color: AppColors.textLight),
//         ),
//         const SizedBox(height: 24),
//         ..._items.map((item) {
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       item.product.image,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item.product.name,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           item.product.category,
//                           style: const TextStyle(
//                             color: AppColors.textLight,
//                             fontSize: 14,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           '\$${item.product.finalPrice.toStringAsFixed(2)}',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.primary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () =>
//                             _updateQuantity(item.product.id, item.quantity - 1),
//                         icon: const Icon(Icons.remove),
//                         style: IconButton.styleFrom(
//                           backgroundColor: AppColors.background,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         child: Text(
//                           '${item.quantity}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () =>
//                             _updateQuantity(item.product.id, item.quantity + 1),
//                         icon: const Icon(Icons.add),
//                         style: IconButton.styleFrom(
//                           backgroundColor: AppColors.background,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 8),
//                   IconButton(
//                     onPressed: () => _removeItem(item.product.id),
//                     icon: const Icon(Icons.delete_outline),
//                     color: AppColors.error,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ],
//     );
//   }

//   Widget _buildOrderSummary(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Order Summary',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 24),
//             _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
//             const SizedBox(height: 12),
//             _summaryRow('Shipping', '\$${shipping.toStringAsFixed(2)}'),
//             const Divider(height: 32),
//             _summaryRow(
//               'Total',
//               '\$${total.toStringAsFixed(2)}',
//               isTotal: true,
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pushNamed(context, '/checkout'),
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   child: Text(
//                     'Proceed to Checkout',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton(
//                 onPressed: () => Navigator.pushNamed(context, '/products'),
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   child: Text('Continue Shopping'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _summaryRow(String label, String value, {bool isTotal = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isTotal ? 18 : 16,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isTotal ? 20 : 16,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
//             color: isTotal ? AppColors.primary : AppColors.textPrimary,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Local helper model
// class _CartItem {
//   final Product product;
//   int quantity;
//   _CartItem({required this.product, required this.quantity});
// }


import 'package:flutter/material.dart';
import '../../widgets/navbar.dart';
import '../../widgets/footer.dart';
import '../../core/constants/app_colors.dart';
import '../../models/product.dart';
import '../../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _items = List.from(demoCart);

  double get subtotal =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);
  double get shipping => subtotal > 100 ? 0 : 9.99;
  double get total => subtotal + shipping;

  void _updateQuantity(String productId, int newQty) {
    setState(() {
      final item = _items.firstWhere((e) => e.product.id == productId);
      if (newQty <= 0) {
        _items.remove(item);
      } else {
        item.quantity = newQty;
      }
    });
  }

  void _removeItem(String productId) {
    setState(() => _items.removeWhere((e) => e.product.id == productId));
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
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
                                Expanded(
                                  flex: 1,
                                  child: _buildOrderSummary(context),
                                ),
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

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: 120, color: AppColors.textLight),
          const SizedBox(height: 24),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Add some products to get started',
            style: TextStyle(fontSize: 16, color: AppColors.textLight),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/products'),
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shopping Cart',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '${_items.length} items',
          style:
              const TextStyle(fontSize: 16, color: AppColors.textLight),
        ),
        const SizedBox(height: 24),
        ..._items.map((item) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.product.image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.product.category,
                          style: const TextStyle(
                              color: AppColors.textLight, fontSize: 14),
                        ),
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _updateQuantity(
                            item.product.id, item.quantity - 1),
                        icon: const Icon(Icons.remove),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _updateQuantity(
                            item.product.id, item.quantity + 1),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
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

  Widget _buildOrderSummary(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            _summaryRow('Shipping', '\$${shipping.toStringAsFixed(2)}'),
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
      {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
