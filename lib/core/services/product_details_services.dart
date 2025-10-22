import 'package:websiteme/core/helper/api_paths.dart';
import 'package:websiteme/core/helper/firestore_services.dart';
import 'package:websiteme/models/product.dart';

abstract class ProductServices {
  Future<List<Product>> fetchAllProducts();
  Future<List<Product>> fetchProductsByCategory(String categoryName);
  Future<Product> fetchProductDetails(String productId);
}

class ProductServicesImpl implements ProductServices {
  final firestore = FirestoreServices.instance;

  @override
  Future<List<Product>> fetchAllProducts() async {
    return firestore.getCollection<Product>(
      path: ApiPaths.products(),
      builder: (data, documentId) => Product.fromMap(data, documentId),
    );
  }

  @override
  Future<List<Product>> fetchProductsByCategory(String categoryName) async {
    return firestore.getCollection<Product>(
      path: ApiPaths.products(),
      queryBuilder: (query) => query.where('category', isEqualTo: categoryName),
      builder: (data, documentId) => Product.fromMap(data, documentId),
    );
  }

  @override
  Future<Product> fetchProductDetails(String productId) async {
    return firestore.getDocument<Product>(
      path: ApiPaths.product(productId),
      builder: (data, documentId) => Product.fromMap(data, documentId),
    );
  }
}
