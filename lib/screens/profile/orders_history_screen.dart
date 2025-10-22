// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:websiteme/logic/cubits/auth/auth_cubit.dart';
// import 'package:websiteme/logic/cubits/auth/auth_state.dart';
// import 'package:websiteme/logic/cubits/order/orders_cubit.dart';
// import 'package:websiteme/logic/cubits/order/orders_states.dart';
// import '../../widgets/navbar.dart';
// import '../../models/order.dart';
// import '../../core/constants/app_colors.dart';

// class OrdersHistoryScreen extends StatelessWidget {
//   const OrdersHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authState = context.watch<AuthCubit>().state;

//     if (authState is AuthAuthenticated) {
//       context.read<OrdersCubit>().loadUserOrders(authState.user.uid);
//     }

//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: const Navbar(),
//       body: BlocBuilder<OrdersCubit, OrdersState>(
//         builder: (context, state) {
//           if (state is OrdersLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is OrdersLoaded) {
//             final orders = state.orders;
//             if (orders.isEmpty) return _buildEmptyState(context);
//             return ListView.builder(
//               padding: const EdgeInsets.all(24),
//               itemCount: orders.length,
//               itemBuilder: (context, index) =>
//                   _buildOrderCard(context, orders[index]),
//             );
//           } else if (state is OrdersError) {
//             return Center(child: Text('❌ Error: ${state.message}'));
//           } else {
//             return _buildEmptyState(context);
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.receipt_long_outlined,
//                 size: 100, color: AppColors.textLight),
//             const SizedBox(height: 24),
//             const Text(
//               'No Orders Yet',
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Your order history will appear here once you make a purchase.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: AppColors.textLight,
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton.icon(
//               onPressed: () => Navigator.pushNamed(context, '/'),
//               icon: const Icon(Icons.shopping_bag_outlined),
//               label: const Text('Start Shopping'),
//               style: ElevatedButton.styleFrom(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOrderCard(BuildContext context, Order order) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Order #${order.id}',
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 _buildStatusChip(order.status),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Text('Placed on ${order.orderDate}',
//                 style: TextStyle(color: AppColors.textSecondary)),
//             const Divider(height: 28),
//             ...order.items.map((item) => ListTile(
//                   leading: Image.network(item.product.image, width: 50),
//                   title: Text(item.product.name),
//                   subtitle: Text('x${item.quantity}'),
//                 )),
//             const Divider(height: 28),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Total: \$${order.total.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 TextButton.icon(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/order-details',
//                         arguments: order);
//                   },
//                   icon: const Icon(Icons.visibility_outlined),
//                   label: const Text('View Details'),
//                   style: TextButton.styleFrom(
//                     foregroundColor: AppColors.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusChip(OrderStatus status) {
//     late final Color color;
//     late final String label;

//     switch (status) {
//       case OrderStatus.pending:
//         color = AppColors.warning;
//         label = 'Pending';
//         break;
//       case OrderStatus.processing:
//         color = Colors.blue;
//         label = 'Processing';
//         break;
//       case OrderStatus.shipped:
//         color = Colors.purple;
//         label = 'Shipped';
//         break;
//       case OrderStatus.delivered:
//         color = AppColors.success;
//         label = 'Delivered';
//         break;
//       case OrderStatus.cancelled:
//         color = AppColors.error;
//         label = 'Cancelled';
//         break;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(label,
//           style: TextStyle(
//               color: color, fontWeight: FontWeight.w600, fontSize: 12)),
//     );
//   }
// }
