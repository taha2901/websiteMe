import 'package:flutter/material.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/models/product.dart';
import 'package:websiteme/widgets/product_card.dart';


class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final products = demoProducts.where((p) => p.rating >= 4.5).toList();

    return Container(
      width: double.infinity,
      padding: Responsive.pagePadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Products',
                      style: TextStyle(
                        fontSize: Responsive.value(
                          context: context,
                          mobile: 24.0,
                          tablet: 28.0,
                          desktop: 36.0,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Top rated items you'll love",
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              if (Responsive.isDesktop(context))
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/products'),
                  icon: const Icon(Icons.arrow_forward, size: 18),
                  label: const Text('View All'),
                ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 32)),

          // Products Grid/List
          ResponsiveLayout(
            mobile: _buildMobileList(products),
            tablet: _buildGrid(products, 3),
            desktop: _buildGrid(products, 4),
          ),
        ],
      ),
    );
  }

  // قائمة أفقية للموبايل
  Widget _buildMobileList(List<Product> products) {
    return SizedBox(
      height: 350,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 250,
            child: ProductCard(product: products[index]),
          );
        },
      ),
    );
  }

  // Grid للتابلت والديسكتوب
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