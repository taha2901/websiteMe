import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class CartIcon extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onPressed;

  const CartIcon({
    super.key,
    this.itemCount = 0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, size: 28),
          onPressed: onPressed ?? () => Navigator.pushNamed(context, '/cart'),
        ),
        if (itemCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                '$itemCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
