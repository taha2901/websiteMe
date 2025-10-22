import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/services/product_details_services.dart';
import 'package:websiteme/logic/cubits/products/products_states.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductServices _productServices;

  ProductCubit(this._productServices) : super(ProductInitial());

  Future<void> fetchAllProducts() async {
    try {
      emit(ProductLoading());
      final products = await _productServices.fetchAllProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> fetchProductsByCategory(String categoryName) async {
    try {
      emit(ProductLoading());
      final products = await _productServices.fetchProductsByCategory(categoryName);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
