import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/services/categories_services.dart';
import 'package:websiteme/logic/cubits/category/categories_states.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryServices _categoryServices;

  CategoryCubit(this._categoryServices) : super(CategoryInitial());

  Future<void> fetchAllCategories() async {
    try {
      emit(CategoryLoading());
      final categories = await _categoryServices.fetchAllCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
