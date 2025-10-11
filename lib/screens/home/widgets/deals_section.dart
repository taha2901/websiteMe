import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/product.dart';
import '../../../widgets/product_card.dart';
import '../../../core/constants/app_colors.dart';

class DealsSection extends StatelessWidget {
  const DealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final products = demoProducts.where((p) => p.isOnSale).toList();
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1000;
    final bool isDesktop = width >= 1000;

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
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.w : 24.w,
        vertical: isDesktop ? 60.h : 40.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔥 العنوان
          Text(
            '🔥 Hot Deals',
            style: TextStyle(
              fontSize: isDesktop ? 32.sp : (isTablet ? 26.sp : 22.sp),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            "Limited time offers — Don't miss out!",
            style: TextStyle(
              fontSize: isDesktop ? 16.sp : 14.sp,
              color: AppColors.textLight,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),

          // 🛍️ قائمة المنتجات (أفقية في الموبايل — شبكية في الديسكتوب)
          if (isMobile)
            SizedBox(
              height: 340.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 240.w,
                    child: ProductCard(product: products[index]),
                  );
                },
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 4 : 3,
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
