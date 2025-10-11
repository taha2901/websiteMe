// import 'package:flutter/foundation.dart';
// import 'package:websiteme/models/category.dart';
// import 'package:websiteme/models/product.dart';

// class ProductProvider with ChangeNotifier {
//   List<Product> _products = [];
//   List<CategoryModel> _categories = [];
//   bool _isLoading = false;
//   String _searchQuery = '';
//   String? _selectedCategory;

//   List<Product> get products {
//     var filtered = _products;
    
//     if (_searchQuery.isNotEmpty) {
//       filtered = filtered.where((p) => 
//         p.name.toLowerCase().contains(_searchQuery.toLowerCase())
//       ).toList();
//     }
    
//     if (_selectedCategory != null) {
//       filtered = filtered.where((p) => 
//         p.category == _selectedCategory
//       ).toList();
//     }
    
//     return filtered;
//   }

//   List<Product> get featuredProducts => 
//       _products.where((p) => p.rating >= 4.5).take(8).toList();
  
//   List<Product> get onSaleProducts => 
//       _products.where((p) => p.isOnSale).take(6).toList();

//   List<CategoryModel> get categories => _categories;
//   bool get isLoading => _isLoading;
//   String get searchQuery => _searchQuery;
//   String? get selectedCategory => _selectedCategory;

//   Future<void> loadProducts() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       await Future.delayed(const Duration(seconds: 1));
//       _products = _generateDemoProducts();
//       _categories = _generateDemoCategories();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void setSearchQuery(String query) {
//     _searchQuery = query;
//     notifyListeners();
//   }

//   void setSelectedCategory(String? category) {
//     _selectedCategory = category;
//     notifyListeners();
//   }

//   List<Product> _generateDemoProducts() {
//     return List.generate(30, (i) => Product(
//       id: 'product_$i',
//       name: 'Premium Product ${i + 1}',
//       description: 'High-quality product with excellent features and design. Perfect for everyday use.',
//       price: 50.0 + (i * 10),
//       discountPrice: i % 3 == 0 ? 40.0 + (i * 8) : null,
//       image: 'https://picsum.photos/400/400?random=$i',
//       images: List.generate(4, (j) => 'https://picsum.photos/400/400?random=${i}_$j'),
//       category: ['Electronics', 'Fashion', 'Home', 'Sports', 'Books'][i % 5],
//       stock: 10 + i,
//       rating: 3.5 + (i % 3) * 0.5,
//       reviewsCount: 10 + (i * 5),
//       features: [
//         'High Quality Materials',
//         'Premium Design',
//         'Long Lasting',
//         'Easy to Use',
//       ],
//     ));
//   }

//   List<CategoryModel> _generateDemoCategories() {
//     return [
//       CategoryModel(id: '1', name: 'Electronics', icon: '📱', 
//                image: 'https://picsum.photos/300/200?1', productsCount: 156),
//       CategoryModel(id: '2', name: 'Fashion', icon: '👔', 
//                image: 'https://picsum.photos/300/200?2', productsCount: 243),
//       CategoryModel(id: '3', name: 'Home', icon: '🏠', 
//                image: 'https://picsum.photos/300/200?3', productsCount: 189),
//       CategoryModel(id: '4', name: 'Sports', icon: '⚽', 
//                image: 'https://picsum.photos/300/200?4', productsCount: 167),
//       CategoryModel(id: '5', name: 'Books', icon: '📚', 
//                image: 'https://picsum.photos/300/200?5', productsCount: 298),
//       CategoryModel(id: '6', name: 'Beauty', icon: '💄', 
//                image: 'https://picsum.photos/300/200?6', productsCount: 134),
//     ];
//   }
// }
