import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/product.dart';
import '../../../widgets/product_card.dart';
import '../../../core/constants/app_colors.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final products = demoProducts.where((p) => p.rating >= 4.5).toList();
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1000;
    final bool isDesktop = width >= 1000;

    final int crossAxisCount = isDesktop
        ? 4
        : isTablet
            ? 3
            : 2;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🏷️ العنوان والزر
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: isDesktop ? 32.sp : (isTablet ? 26.sp : 22.sp),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Top rated items you'll love",
                    style: TextStyle(
                      fontSize: isDesktop ? 16.sp : 14.sp,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/products'),
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: const Text('View All'),
              ),
            ],
          ),

          SizedBox(height: 32.h),

          // ✅ عرض المنتجات بشكل متجاوب
          isMobile
              ? SizedBox(
                  height: 320.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 220.w,
                        child: ProductCard(product: products[index]),
                      );
                    },
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.h,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) =>
                      ProductCard(product: products[index]),
                ),
        ],
      ),
    );
  }
}
