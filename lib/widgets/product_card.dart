import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/logic/cubits/cart/cart_cubit.dart';
import 'package:websiteme/logic/cubits/cart/cart_states.dart';
import 'package:websiteme/logic/cubits/favourite/fav_cubit.dart';
import 'package:websiteme/logic/cubits/favourite/fav_states.dart';
import 'package:websiteme/logic/cubits/auth/auth_cubit.dart';
import 'package:websiteme/logic/cubits/auth/auth_state.dart';
import '../models/product.dart';

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
    final authState = context.watch<AuthCubit>().state;
    final user = authState is AuthAuthenticated ? authState.user : null;

    final card = Material(
      color: Colors.transparent,
      child: InkWell(
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
              children: [_buildImage(context, user), _buildInfo(context)],
            ),
          ),
        ),
      ),
    );

    // Hover effect (ويب فقط)
    return MouseRegion(
      onEnter: (_) {
        if (Responsive.isDesktop(context)) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (Responsive.isDesktop(context)) setState(() => _isHovered = false);
      },
      child: card,
    );
  }

  Widget _buildImage(BuildContext context, dynamic user) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: Image.network(
            widget.product.image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.image_not_supported, size: 48),
            ),
          ),
        ),

        // عرض الخصم
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

        // زر المفضلة ❤️
        Positioned(
          top: 10,
          right: 10,
          child: Material(
            color: Colors.white,
            shape: const CircleBorder(),
            elevation: 2,
            child: BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, state) {
                final favCubit = context.read<FavouriteCubit>();
                final isFav = favCubit.isFavourite(widget.product.id);

                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? AppColors.error : Colors.grey,
                  ),
                  iconSize: 20,
                  onPressed: () {
                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please log in to add favourites.'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    }
                    favCubit.toggleFavourite(widget.product);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfo(BuildContext context) {
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
                        mobile: 14.0,
                        tablet: 18.0,
                        desktop: 20.0,
                      ),
                    ),
                  ),
                ],
              ),

              // زر السلة 🛒
              BlocBuilder<CartCubit, CartState>(
                builder: (context, cartState) {
                  bool isInCart = false;
                  if (cartState is CartLoaded) {
                    isInCart = cartState.items.any(
                      (i) => i.productId == widget.product.id,
                    );
                  }

                  return IconButton(
                    onPressed: () {
                      final authState = context.read<AuthCubit>().state;
                      final user = authState is AuthAuthenticated
                          ? authState.user
                          : null;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please log in to add to cart.'),
                          ),
                        );
                        return;
                      }

                      final cartCubit = context.read<CartCubit>();

                      if (isInCart) {
                        // نحذف
                        cartCubit.removeFromCart(widget.product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.product.name} removed from cart',
                            ),
                          ),
                        );
                      } else {
                        // نضيف
                        cartCubit.addToCartFromProduct(widget.product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.product.name} added to cart!',
                            ),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      isInCart
                          ? Icons.remove_shopping_cart
                          : Icons.add_shopping_cart,
                    ),
                    color: Colors.white,
                    style: IconButton.styleFrom(
                      backgroundColor: isInCart
                          ? Colors.grey
                          : AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
