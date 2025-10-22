import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/logic/cubits/category/categories_cubit.dart';
import 'package:websiteme/logic/cubits/category/categories_states.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          return _buildContent(context, state.categories);
        } else if (state is CategoryError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(BuildContext context, List categories) {
    return Container(
      width: double.infinity,
      padding: Responsive.pagePadding(context),
      child: Column(
        children: [
          Text(
            'Shop by Category',
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
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              color: AppColors.textLight,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 40)),
          LayoutBuilder(
            builder: (context, constraints) {
              int count = constraints.maxWidth < 600
                  ? 2
                  : constraints.maxWidth < 1000
                      ? 4
                      : 6;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final c = categories[index];
                  return _CategoryCard(category: c);
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
  final dynamic category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.pushNamed(
        context,
        '/products',
        arguments: {'category': category.name},
      ),
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
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Image.network(category.image)),
              ),
              const SizedBox(height: 12),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.fontSize(context, 14),
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
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
