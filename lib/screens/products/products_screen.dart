import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1100;
    final isTablet = width >= 600 && width < 1100;

    return Scaffold(
      appBar: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ نلف المحتوى كله في Container عشان يتحكم في العرض
            Container(
              constraints: const BoxConstraints(maxWidth: 1400),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sidebar for desktop only
                    if (isDesktop)
                      SizedBox(
                        width: 260.w,
                        child: _buildFilterSidebar(context),
                      ),

                    // ✅ Expanded شيلناها واستبدلناها بـ Flexible Container
                    Expanded(
                      child: Column(
                        children: [
                          _buildHeader(context, products.length),
                          products.isEmpty
                              ? _buildEmptyState()
                              : _buildProductsGrid(
                                  context,
                                  products,
                                  isDesktop,
                                  isTablet,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  // 🧱 Sidebar (Desktop only)
  Widget _buildFilterSidebar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        children: [
          Text(
            'Filters (Demo)',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24.h),
          Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
          SizedBox(height: 12.h),
          ...['Electronics', 'Wearables', 'Cameras', 'Accessories'].map(
            (category) => CheckboxListTile(
              title: Text(category, style: TextStyle(fontSize: 13.sp)),
              subtitle: Text(
                'Demo data',
                style: TextStyle(fontSize: 11.sp, color: AppColors.textLight),
              ),
              value: false,
              onChanged: (_) {},
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
          Divider(height: 32.h),
          Text(
            'Price Range',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
          SizedBox(height: 12.h),
          RangeSlider(
            values: const RangeValues(0, 500),
            min: 0,
            max: 1000,
            divisions: 20,
            labels: const RangeLabels('\$0', '\$500'),
            onChanged: (values) {},
          ),
          Divider(height: 32.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Clear Filters'),
            ),
          ),
        ],
      ),
    );
  }

  // 🧭 Header
  Widget _buildHeader(BuildContext context, int count) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count Products',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Text('Sort by: ', style: TextStyle(fontSize: 14.sp)),
              SizedBox(width: 8.w),
              DropdownButton<String>(
                value: 'featured',
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'featured', child: Text('Featured')),
                  DropdownMenuItem(
                    value: 'price_low',
                    child: Text('Price: Low to High'),
                  ),
                  DropdownMenuItem(
                    value: 'price_high',
                    child: Text('Price: High to Low'),
                  ),
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

  // 🧩 Products Grid
  Widget _buildProductsGrid(
    BuildContext context,
    List products,
    bool isDesktop,
    bool isTablet,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(20.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 4 : (isTablet ? 3 : 2),
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: isDesktop ? 0.55 : (isTablet ? 0.5 : 0.4),
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }

  // 🪹 Empty State
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80.sp, color: AppColors.textLight),
            SizedBox(height: 16.h),
            Text(
              'No products found',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              'Try adjusting your filters',
              style: TextStyle(color: AppColors.textLight, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
