import 'package:flutter/material.dart';
import 'package:websiteme/core/constants/app_constants.dart';
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
    final card = GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/product-detail',
        arguments: widget.product,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered && Responsive.isDesktop(context)
            ? (Matrix4.identity()..scale(1.02))
            : Matrix4.identity(),
        child: Card(
          elevation: _isHovered ? 8 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              _buildInfo(),
            ],
          ),
        ),
      ),
    );

    // Hover effect (ويب فقط)
    return MouseRegion(
      onEnter: (_) {
        if (Responsive.isDesktop(context)) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (Responsive.isDesktop(context)) {
          setState(() => _isHovered = false);
        }
      },
      child: card,
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: Image.network(
            widget.product.image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported, size: 48),
              );
            },
          ),
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

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.category,
            style: TextStyle(
              color: AppColors.textLight,
              fontSize: Responsive.fontSize(context, 12),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.fontSize(context, 15),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                widget.product.rating.toStringAsFixed(1),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Responsive.fontSize(context, 13),
                ),
              ),
              Text(
                ' (${widget.product.reviewsCount})',
                style: TextStyle(
                  color: AppColors.textLight,
                  fontSize: Responsive.fontSize(context, 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.product.isOnSale)
                    Text(
                      widget.product.price.toStringAsFixed(2),
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textLight,
                        fontSize: Responsive.fontSize(context, 12),
                      ),
                    ),
                  Text(
                    widget.product.finalPrice.toStringAsFixed(2),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.value(
                        context: context,
                        mobile: 16.0,
                        tablet: 18.0,
                        desktop: 20.0,
                      ),
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