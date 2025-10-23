import 'package:flutter/material.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/models/product.dart';
import '../../widgets/navbar.dart';
import '../../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = demoProducts;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Navbar(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: ResponsiveLayout(
              mobile: _buildMobileLayout(products),
              tablet: _buildTabletLayout(products),
              desktop: _buildDesktopLayout(products),
            ),
          ),
        ),
      ),
    );
  }

  /// 🟢 Desktop layout (Sidebar + Grid)
  Widget _buildDesktopLayout(List<Product> products) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 260, child: _buildFilterSidebar()),
        const SizedBox(width: 20),
        Expanded(child: _buildProductsSection(products, crossAxisCount: 4)),
      ],
    );
  }

  /// 🟢 Tablet layout
  Widget _buildTabletLayout(List<Product> products) {
    return _buildProductsSection(products, crossAxisCount: 3);
  }

  /// 🟢 Mobile layout
  Widget _buildMobileLayout(List<Product> products) {
    return _buildProductsSection(products, crossAxisCount: 2);
  }

  /// 🧱 Sidebar
  Widget _buildFilterSidebar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filters', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ...['Electronics', 'Wearables', 'Cameras'].map(
            (category) => CheckboxListTile(
              title: Text(category),
              value: false,
              onChanged: (_) {},
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  /// 🧩 Products Section
  Widget _buildProductsSection(List<Product> products, {required int crossAxisCount}) {
    return Column(
      children: [
        _buildHeader(products.length),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.52,
          ),
          itemBuilder: (context, index) => ProductCard(product: products[index]),
        ),
      ],
    );
  }

  /// 🧭 Header
  Widget _buildHeader(int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$count Products', style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              const Text('Sort by: '),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: 'featured',
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'featured', child: Text('Featured')),
                  DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
                  DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
                ],
                onChanged: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
