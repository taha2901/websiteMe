// import 'package:websiteme/models/cart_item.dart';

// enum OrderStatus { pending, processing, shipped, delivered, cancelled }

// class Order {
//   final String id;
//   final List<CartItem> items;
//   final double total;
//   final OrderStatus status;
//   final DateTime orderDate;
//   final String shippingAddress;
//   final String? trackingNumber;

//   Order({
//     required this.id,
//     required this.items,
//     required this.total,
//     required this.status,
//     required this.orderDate,
//     required this.shippingAddress,
//     this.trackingNumber,
//   });
// }


// final List<Order> demoOrders = [
//   Order(
//     id: 'o1',
//     items: demoCart,
//     total: demoCart.fold(0, (sum, item) => sum + item.totalPrice),
//     status: OrderStatus.delivered,
//     orderDate: DateTime.now().subtract(const Duration(days: 5)),
//     shippingAddress: '123 Main Street, Cairo, Egypt',
//     trackingNumber: 'TRK12345678',
//   ),
//   Order(
//     id: 'o2',
//     items: [demoCart.first],
//     total: demoCart.first.totalPrice,
//     status: OrderStatus.processing,
//     orderDate: DateTime.now().subtract(const Duration(days: 1)),
//     shippingAddress: '45 Downtown Avenue, Giza',
//     trackingNumber: 'TRK98765432',
//   ),
//   Order(
//     id: 'o3',
//     items: demoCart,
//     total: demoCart.fold(0, (sum, item) => sum + item.totalPrice),
//     status: OrderStatus.delivered,
//     orderDate: DateTime.now().subtract(const Duration(days: 5)),
//     shippingAddress: '123 Main Street, Cairo, Egypt',
//     trackingNumber: 'TRK12345678',
//   ),
//   Order(
//     id: 'o4',
//     items: [demoCart.first],
//     total: demoCart.first.totalPrice,
//     status: OrderStatus.processing,
//     orderDate: DateTime.now().subtract(const Duration(days: 1)),
//     shippingAddress: '45 Downtown Avenue, Giza',
//     trackingNumber: 'TRK98765432',
//   ),
//   Order(
//     id: 'o5',
//     items: demoCart,
//     total: demoCart.fold(0, (sum, item) => sum + item.totalPrice),
//     status: OrderStatus.delivered,
//     orderDate: DateTime.now().subtract(const Duration(days: 5)),
//     shippingAddress: '123 Main Street, Cairo, Egypt',
//     trackingNumber: 'TRK12345678',
//   ),
//   Order(
//     id: 'o6',
//     items: [demoCart.first],
//     total: demoCart.first.totalPrice,
//     status: OrderStatus.processing,
//     orderDate: DateTime.now().subtract(const Duration(days: 1)),
//     shippingAddress: '45 Downtown Avenue, Giza',
//     trackingNumber: 'TRK98765432',
//   ),
// ];
