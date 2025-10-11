// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../widgets/navbar.dart';
// import '../../widgets/footer.dart';
// import '../../widgets/product_card.dart';
// import '../../providers/product_provider.dart';
// import '../../core/constants/app_colors.dart';

// class ProductsScreen extends StatelessWidget {
//   const ProductsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = context.watch<ProductProvider>();
//     final products = productProvider.products;
//     final isDesktop = MediaQuery.of(context).size.width >= 1100;

//     return Scaffold(
//       appBar: const Navbar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 // Filters Sidebar (Desktop only)
//                 if (isDesktop) _buildFilterSidebar(context, productProvider),
//                 // Products Grid
//                 Expanded(
//                   child: Column(
//                     children: [
//                       _buildHeader(context, products.length),
//                       Expanded(
//                         child: products.isEmpty
//                             ? _buildEmptyState()
//                             : _buildProductsGrid(context, products),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Footer(),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterSidebar(BuildContext context, ProductProvider provider) {
//     return Container(
//       width: 280,
//       decoration: const BoxDecoration(
//         color: AppColors.background,
//         border: Border(right: BorderSide(color: AppColors.border)),
//       ),
//       child: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           const Text(
//             'Filters',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 24),
//           const Text(
//             'Categories',
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 12),
//           ...provider.categories.map((category) {
//             final isSelected = provider.selectedCategory == category.name;
//             return CheckboxListTile(
//               title: Text(category.name),
//               subtitle: Text('${category.productsCount} items'),
//               value: isSelected,
//               onChanged: (value) {
//                 provider.setSelectedCategory(value! ? category.name : null);
//               },
//               controlAffinity: ListTileControlAffinity.leading,
//               contentPadding: EdgeInsets.zero,
//             );
//           }),
//           const Divider(height: 32),
//           const Text(
//             'Price Range',
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 12),
//           RangeSlider(
//             values: const RangeValues(0, 500),
//             min: 0,
//             max: 1000,
//             divisions: 20,
//             labels: const RangeLabels('\$0', '\$500'),
//             onChanged: (values) {},
//           ),
//           const Divider(height: 32),
//           ElevatedButton(
//             onPressed: () {
//               provider.setSelectedCategory(null);
//               provider.setSearchQuery('');
//             },
//             child: const Text('Clear Filters'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context, int count) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(bottom: BorderSide(color: AppColors.border)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             '$count Products',
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Row(
//             children: [
//               const Text('Sort by: '),
//               DropdownButton<String>(
//                 value: 'featured',
//                 underline: const SizedBox(),
//                 items: const [
//                   DropdownMenuItem(value: 'featured', child: Text('Featured')),
//                   DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
//                   DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
//                   DropdownMenuItem(value: 'rating', child: Text('Top Rated')),
//                 ],
//                 onChanged: (value) {},
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductsGrid(BuildContext context, List products) {
//     final isDesktop = MediaQuery.of(context).size.width >= 1100;
//     final isTablet = MediaQuery.of(context).size.width >= 600;

//     return GridView.builder(
//       padding: const EdgeInsets.all(20),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: isDesktop ? 4 : (isTablet ? 3 : 2),
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         childAspectRatio: 0.7,
//       ),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         return ProductCard(product: products[index]);
//       },
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.search_off, size: 80, color: AppColors.textLight),
//           const SizedBox(height: 16),
//           const Text(
//             'No products found',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Try adjusting your filters',
//             style: TextStyle(color: AppColors.textLight),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:websiteme/models/product.dart';
import '../../widgets/navbar.dart';
import '../../widgets/footer.dart';
import '../../widgets/product_card.dart';
import '../../core/constants/app_colors.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = demoProducts;
    final isDesktop = MediaQuery.of(context).size.width >= 1100;

    return Scaffold(
      appBar: const Navbar(),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Filters Sidebar (Desktop only)
                if (isDesktop) _buildFilterSidebar(context),
                // Products Grid
                Expanded(
                  child: Column(
                    children: [
                      _buildHeader(context, products.length),
                      Expanded(
                        child: products.isEmpty
                            ? _buildEmptyState()
                            : _buildProductsGrid(context, products),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }

  Widget _buildFilterSidebar(BuildContext context) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Filters (Demo)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ...['Electronics', 'Wearables', 'Cameras', 'Accessories']
              .map((category) => CheckboxListTile(
                    title: Text(category),
                    subtitle: const Text('Demo data'),
                    value: false,
                    onChanged: (_) {},
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  )),
          const Divider(height: 32),
          const Text(
            'Price Range',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          RangeSlider(
            values: const RangeValues(0, 500),
            min: 0,
            max: 1000,
            divisions: 20,
            labels: const RangeLabels('\$0', '\$500'),
            onChanged: (values) {},
          ),
          const Divider(height: 32),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count Products',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              const Text('Sort by: '),
              DropdownButton<String>(
                value: 'featured',
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'featured', child: Text('Featured')),
                  DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
                  DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
                  DropdownMenuItem(value: 'rating', child: Text('Top Rated')),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context, List products) {
    final isDesktop = MediaQuery.of(context).size.width >= 1100;
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 4 : (isTablet ? 3 : 2),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: AppColors.textLight),
          const SizedBox(height: 16),
          const Text(
            'No products found',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(color: AppColors.textLight),
          ),
        ],
      ),
    );
  }
}
