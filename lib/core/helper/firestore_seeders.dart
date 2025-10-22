import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:websiteme/core/helper/api_paths.dart';
import 'package:websiteme/core/helper/firestore_services.dart';
import 'package:websiteme/models/category.dart';
import 'package:websiteme/models/product.dart';

class FirestoreSeeder {
  final _firestore = FirestoreServices.instance;

  /// 🛍️ رفع المنتجات التجريبية
  Future<void> uploadDemoProducts() async {
    for (final product in demoProducts) {
      final productData = {
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'discountPrice': product.discountPrice,
        'image': product.image,
        'images': product.images,
        'oldPrice': product.oldPrice,
        'category': product.category,
        'stock': product.stock,
        'rating': product.rating,
        'reviewsCount': product.reviewsCount,
        'features': product.features,
        'specifications': product.specifications,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore.setData(
        path: ApiPaths.product(product.id),
        data: productData,
      );

    }

  }

  /// 🗂️ رفع الكاتيجوريز التجريبية
  Future<void> uploadDemoCategories() async {
    for (final category in demoCategories) {
      final categoryData = {
        'name': category.name,
        'image': category.image,
        'productsCount': category.productsCount,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore.setData(
        path: ApiPaths.categories() + category.id,
        data: categoryData,
      );

    }

  }
}
