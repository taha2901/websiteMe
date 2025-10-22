import 'package:websiteme/models/product.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<Product> favourites;
  FavouriteLoaded(this.favourites);
}

class FavouriteError extends FavouriteState {
  final String message;
  FavouriteError(this.message);
}
