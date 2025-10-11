import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product.dart';
import '../core/constants/app_colors.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1000;
    final isDesktop = width >= 1000;

    final double imageHeight = isMobile
        ? 150
        : isTablet
        ? 190
        : 220;

    final double fontSizeTitle = isDesktop ? 16 : (isTablet ? 15 : 14);
    final double fontSizePrice = isDesktop ? 20 : (isTablet ? 18 : 16);

    final card = GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/product-detail',
        arguments: widget.product,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.02))
            : Matrix4.identity(),
        child: Card(
          elevation: _isHovered ? 8 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isHorizontal = constraints.maxWidth > 500 && isDesktop;
              return isHorizontal
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImage(imageHeight, isHorizontal: true),
                        Expanded(
                          child: _buildInfo(
                            fontSizeTitle,
                            fontSizePrice,
                            isMobile,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImage(imageHeight),
                        _buildInfo(fontSizeTitle, fontSizePrice, isMobile),
                      ],
                    );
            },
          ),
        ),
      ),
    );

    // ✅ Hover شغال بس على الويب
    return MouseRegion(
      onEnter: (_) {
        if (isDesktop) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (isDesktop) setState(() => _isHovered = false);
      },
      child: card,
    );
  }

  Widget _buildImage(double height, {bool isHorizontal = false}) {
    return Stack(
      children: [
        SizedBox(
          width: isHorizontal ? 220 : double.infinity,
          height: height,
          child: Image.network(widget.product.image, fit: BoxFit.cover),
        ),
        if (widget.product.isOnSale)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '-${widget.product.discountPercentage}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        Positioned(
          top: 10,
          right: 10,
          child: Material(
            color: Colors.white,
            shape: const CircleBorder(),
            elevation: 2,
            child: IconButton(
              icon: const Icon(Icons.favorite_border),
              iconSize: 20,
              color: AppColors.error,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to wishlist!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfo(double fontSizeTitle, double fontSizePrice, bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 10.w : 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.category,
            style: TextStyle(color: AppColors.textLight, fontSize: 12.sp),
          ),
           SizedBox(height: 2.h),
          Text(
            widget.product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: fontSizeTitle,
            ),
          ),
           SizedBox(height: 4.h),
          Row(
            children: [
               Icon(Icons.star, color: Colors.amber, size: 16.w),
               SizedBox(width: 4.w),
              Text(
                widget.product.rating.toStringAsFixed(1),
                style:  TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                ' (${widget.product.reviewsCount})',
                style:  TextStyle(
                  color: AppColors.textLight,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
           SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.product.isOnSale)
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style:  TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textLight,
                        fontSize: 12.sp,
                      ),
                    ),
                  Text(
                    '\$${widget.product.finalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizePrice,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.product.name} added to cart!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
