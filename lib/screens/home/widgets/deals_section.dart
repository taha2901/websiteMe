// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../providers/product_provider.dart';
// import '../../../widgets/product_card.dart';
// import '../../../core/constants/app_colors.dart';

// class DealsSection extends StatelessWidget {
//   const DealsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final products = context.watch<ProductProvider>().onSaleProducts;

//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.primary.withOpacity(0.05),
//             AppColors.secondary.withOpacity(0.05),
//           ],
//         ),
//       ),
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         children: [
//           const Text(
//             '🔥 Hot Deals',
//             style: TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Limited time offers - Don\'t miss out!',
//             style: TextStyle(
//               fontSize: 16,
//               color: AppColors.textLight,
//             ),
//           ),
//           const SizedBox(height: 32),
//           SizedBox(
//             height: 400,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                   width: 300,
//                   child: ProductCard(product: products[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../../models/product.dart'; // ✅ علشان demoProducts
import '../../../widgets/product_card.dart';
import '../../../core/constants/app_colors.dart';

class DealsSection extends StatelessWidget {
  const DealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ بدل Provider: ناخد المنتجات اللي عليها خصم من demoProducts
    final products = demoProducts.where((p) => p.isOnSale).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.secondary.withOpacity(0.05),
          ],
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            '🔥 Hot Deals',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Limited time offers - Don\'t miss out!',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 32),

          // ✅ عرض المنتجات اللي عليها خصم فقط
          SizedBox(
            height: 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 300,
                  child: ProductCard(product: products[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
