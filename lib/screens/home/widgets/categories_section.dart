import 'package:flutter/material.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/models/category.dart';


class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = demoCategories;

    return Container(
      width: double.infinity,
      padding: Responsive.pagePadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // العنوان
          Text(
            'Shop by Category',
            textAlign: TextAlign.center,
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
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Text(
            'Find what you need from our wide selection',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              color: AppColors.textLight,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 40)),

          // Grid Categories
          LayoutBuilder(
            builder: (context, constraints) {
              // عدد الأعمدة بناءً على عرض الشاشة
              int crossAxisCount;
              if (constraints.maxWidth < 600) {
                crossAxisCount = 2;
              } else if (constraints.maxWidth < 1000) {
                crossAxisCount = 4;
              } else {
                crossAxisCount = 6;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _CategoryCard(category: category);
                },
              );
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
      borderRadius: BorderRadius.circular(16),
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
          borderRadius: BorderRadius.circular(16),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // أيقونة
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    category.icon,
                    style: TextStyle(
                      fontSize: Responsive.value(
                        context: context,
                        mobile: 28.0,
                        tablet: 32.0,
                        desktop: 36.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // الاسم
              Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.fontSize(context, 14),
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),

              // عدد المنتجات
              Text(
                '${category.productsCount} items',
                style: TextStyle(
                  color: AppColors.textLight,
                  fontSize: Responsive.fontSize(context, 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}