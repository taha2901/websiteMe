import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/services/order_service.dart';
import 'package:websiteme/logic/cubits/order/order_states.dart';
import 'package:websiteme/models/cart_item.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderServices _orderServices;
  OrderCubit(this._orderServices) : super(OrderInitial());

  Future<void> placeOrder({
    required String userId,
    required List<CartItemModel> items,
    required double total,
    required String paymentMethod,
    required Map<String, dynamic> address,
  }) async {
    try {
      emit(OrderLoading());
      await _orderServices.placeOrder(
        userId: userId,
        items: items,
        total: total,
        paymentMethod: paymentMethod,
        address: address,
      );
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  
}
