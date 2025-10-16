import 'package:flutter/material.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import '../../../models/product.dart';
import '../../../widgets/product_card.dart';
import '../../../core/constants/app_colors.dart';

class DealsSection extends StatelessWidget {
  const DealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final products = demoProducts.where((p) => p.isOnSale).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.04),
            AppColors.secondary.withOpacity(0.04),
          ],
        ),
      ),
      padding: Responsive.pagePadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // العنوان
          Text(
            '🔥 Hot Deals',
            style: TextStyle(
              fontSize: Responsive.value(
                context: context,
                mobile: 24.0,
                tablet: 28.0,
                desktop: 36.0,
              ),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Limited time offers — Don't miss out!",
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              color: AppColors.textLight,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Responsive.spacing(context, 40)),

          // Products
          ResponsiveLayout(
            mobile: _buildMobileList(products),
            tablet: _buildGrid(products, 3),
            desktop: _buildGrid(products, 4),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileList(List<Product> products) {
    return SizedBox(
      height: 340,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 240,
            child: ProductCard(product: products[index]),
          );
        },
      ),
    );
  }

  Widget _buildGrid(List<Product> products, int columns) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}