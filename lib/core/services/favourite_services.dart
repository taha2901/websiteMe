import 'package:websiteme/core/helper/api_paths.dart';
import 'package:websiteme/core/helper/firestore_services.dart';
import 'package:websiteme/models/product.dart';

abstract class FavouriteServices {
  Future<void> addFavourite({required String userId, required Product product});
  Future<void> removeFavourite({required String userId, required String productId});
  Future<List<Product>> getFavourite({required String userId});
}

class FavouriteServicesImpl implements FavouriteServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<void> addFavourite({required String userId, required Product product}) async {
    await firestoreServices.setData(
      path: ApiPaths.favouriteProduct(userId, product.id),
      data: product.toMap(),
    );
  }

  @override
  Future<void> removeFavourite({required String userId, required String productId}) async {
    await firestoreServices.deleteData(
      path: ApiPaths.favouriteProduct(userId, productId),
    );
  }

  @override
  Future<List<Product>> getFavourite({required String userId}) async {
    final res = await firestoreServices.getCollection(
      path: ApiPaths.favouriteProducts(userId),
      builder: (data, documentId) => Product.fromMap(data, documentId),
    );
    return res;
  }
}
