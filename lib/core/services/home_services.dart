// abstract class HomeServices {
//   Future<List<ProductItemModel>> fetchProducts();
//   Future<List<HomeCarouselItemModel>> fetchHomeCarouselItems();
//   Future<List<CategoryModel>> fetchCategories();
// }

// class HomeServicesImpl implements HomeServices {
//   final firestoreServices = FirestoreServices.instance;
//   @override
//   Future<List<ProductItemModel>> fetchProducts() async {
//     final resultOfProducts = await firestoreServices.getCollection<ProductItemModel>(
//       path: ApiPaths.products(),
//       builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
//     );
//     return resultOfProducts;
//   }

//   @override
//   Future<List<CategoryModel>> fetchCategories() async {
//     final resultOfCategory =
//         await firestoreServices.getCollection<CategoryModel>(
//       path: ApiPaths.categories(),
//       builder: (data, documentId) => CategoryModel.fromMap(data),
//     );
//     return resultOfCategory;
//   }

//   @override
//   Future<List<HomeCarouselItemModel>> fetchHomeCarouselItems() async {
//     final result = await firestoreServices.getCollection<HomeCarouselItemModel>(
//       path: ApiPaths.announcments(),
//       builder: (data, documentId) => HomeCarouselItemModel.fromMap(data),
//     );
//     return result;
//   }

// }
