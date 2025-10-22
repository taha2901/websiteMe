import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/logic/cubits/products/products_cubit.dart';
import 'package:websiteme/logic/cubits/products/products_states.dart';
import 'package:websiteme/widgets/product_card.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final products =
              state.products.where((p) => p.rating >= 4.5).toList();
          return _buildContent(context, products);
        } else if (state is ProductError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(BuildContext context, List products) {
    return Container(
      width: double.infinity,
      padding: Responsive.pagePadding(context),
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
          const SizedBox(height: 8),
          Text(
            "Top rated items you'll love",
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              color: AppColors.textLight,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 24)),
          ResponsiveLayout(
            mobile: _buildMobileList(products),
            tablet: _buildGrid(products, 3),
            desktop: _buildGrid(products, 4),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileList(List products) {
    return SizedBox(
      height: 350,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) => SizedBox(
          width: 250,
          child: ProductCard(product: products[index]),
        ),
      ),
    );
  }

  Widget _buildGrid(List products, int columns) {
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
