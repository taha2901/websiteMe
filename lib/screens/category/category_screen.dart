import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/logic/cubits/category/categories_cubit.dart';
import 'package:websiteme/logic/cubits/category/categories_states.dart';
import 'package:websiteme/models/category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is CategoryLoaded) {
            return _buildContent(context, state.categories);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<CategoryModel> categories) {
    return SingleChildScrollView(
      padding: Responsive.pagePadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shop by Category",
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
          const SizedBox(height: 12),
          Text(
            "Browse our product categories and find your favorite items.",
            style: TextStyle(
              color: AppColors.textLight,
              fontSize: Responsive.fontSize(context, 16),
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              if (constraints.maxWidth < 600) {
                crossAxisCount = 2;
              } else if (constraints.maxWidth < 1000) {
                crossAxisCount = 3;
              } else {
                crossAxisCount = 5;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) =>
                    _CategoryCard(category: categories[index]),
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
          border: Border.all(color: AppColors.border.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // صورة
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                category.image,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            // اسم الكاتيجوري
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.fontSize(context, 16),
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            // عدد المنتجات
            Text(
              '${category.productsCount} products',
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: Responsive.fontSize(context, 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
