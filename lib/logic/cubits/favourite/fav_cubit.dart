import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/logic/cubits/favourite/fav_states.dart';
import 'package:websiteme/models/product.dart';
import 'package:websiteme/core/services/favourite_services.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteServices _favouriteServices;
  final String userId;

  FavouriteCubit(this._favouriteServices, this.userId)
    : super(FavouriteInitial());

  List<Product> favourites = [];

  Future<void> loadFavourites() async {
    try {
      emit(FavouriteLoading());
      favourites = await _favouriteServices.getFavourite(userId: userId);
      emit(FavouriteLoaded(favourites));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> toggleFavourite(Product product) async {
    try {
      final isFav = favourites.any((p) => p.id == product.id);

      if (isFav) {
        favourites.removeWhere(
          (p) => p.id == product.id,
        ); //حذفناه من القايمه المحليه
        await _favouriteServices.removeFavourite(
          userId: userId,
          productId: product.id,
        ); // وهنا حذفناه من الالسيرفر نفسه
      } else {
        favourites.add(product);
        await _favouriteServices.addFavourite(userId: userId, product: product);
      }

      emit(FavouriteLoaded(List.from(favourites)));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  bool isFavourite(String productId) {
    return favourites.any((p) => p.id == productId);
  }
}
