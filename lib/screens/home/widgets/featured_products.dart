// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../providers/product_provider.dart';
// import '../../../widgets/product_card.dart';
// import '../../../core/constants/app_colors.dart';

// class FeaturedProducts extends StatelessWidget {
//   const FeaturedProducts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final products = context.watch<ProductProvider>().featuredProducts;
//     final isDesktop = MediaQuery.of(context).size.width >= 1100;
//     final isTablet = MediaQuery.of(context).size.width >= 600;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Featured Products',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Top rated items you\'ll love',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: AppColors.textLight,
//                     ),
//                   ),
//                 ],
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pushNamed(context, '/products'),
//                 child: const Row(
//                   children: [
//                     Text('View All'),
//                     Icon(Icons.arrow_forward, size: 18),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 32),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: isDesktop ? 4 : (isTablet ? 3 : 2),
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               childAspectRatio: 0.7,
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               return ProductCard(product: products[index]);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../models/product.dart'; // ✅ لاستخدام demoProducts
import '../../../widgets/product_card.dart';
import '../../../core/constants/app_colors.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ بدل Provider: نجيب المنتجات اللي تقييمها عالي
    final products = demoProducts.where((p) => p.rating >= 4.5).toList();

    final isDesktop = MediaQuery.of(context).size.width >= 1100;
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // العنوان والزر
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Top rated items you\'ll love',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/products'),
                child: const Row(
                  children: [
                    Text('View All'),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // ✅ شبكة المنتجات المميزة
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
          ),
        ],
      ),
    );
  }
}
