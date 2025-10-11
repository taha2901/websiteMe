import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:websiteme/models/category.dart';
import '../../../core/constants/app_colors.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = demoCategories;
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1000;
    final bool isDesktop = width >= 1000;

    // عدد الأعمدة حسب حجم الشاشة
    final int crossAxisCount = isDesktop
        ? 6
        : isTablet
            ? 4
            : 2;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏷️ العنوان الرئيسي
          Text(
            'Shop by Category',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 32.sp : (isTablet ? 26.sp : 22.sp),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Find what you need from our wide selection',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 16.sp : 14.sp,
              color: AppColors.textLight,
            ),
          ),
          SizedBox(height: 36.h),

          // 🧩 شبكة التصنيفات
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: isMobile ? 0.9 : 0.85,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return _CategoryCard(category: category);
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/products',
          arguments: {'category': category.name},
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // أيقونة الفئة
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    category.icon,
                    style: TextStyle(fontSize: 32.sp),
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // الاسم
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),

              // عدد المنتجات
              Text(
                '${category.productsCount} items',
                style: TextStyle(
                  color: AppColors.textLight,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
