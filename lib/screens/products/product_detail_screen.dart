import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../widgets/navbar.dart';
import '../../widgets/footer.dart';
import '../../core/constants/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;
  final List<Map<String, dynamic>> _cart = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      appBar: const Navbar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 32 : 16,
              vertical: isDesktop ? 24 : 12,
            ),
            child: Column(
              children: [
                // --- Product Main Section ---
                Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section
                    Flexible(
                      flex: 1,
                      child: _buildImageGallery(
                        height: isDesktop
                            ? 500
                            : isTablet
                            ? 400
                            : 300,
                      ),
                    ),
                    SizedBox(
                      width: isDesktop ? 48 : 0,
                      height: isDesktop ? 0 : 24,
                    ),
                    // Info Section
                    Flexible(
                      flex: 1,
                      child: _buildProductInfo(isTablet: isTablet),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                _buildProductDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery({required double height}) {
    return Column(
      children: [
        // --- Main Image ---
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.product.images[_selectedImageIndex],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // --- Thumbnails ---
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.product.images.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedImageIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedImageIndex = index),
                child: Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.product.images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo({required bool isTablet}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 8 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.category,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.name,
            style: TextStyle(
              fontSize: isTablet ? 26 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Rating
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < widget.product.rating.floor()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 22,
                );
              }),
              const SizedBox(width: 8),
              Text(
                '${widget.product.rating} (${widget.product.reviewsCount} reviews)',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.product.isOnSale) ...[
                Text(
                  '\$${widget.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.textLight,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Save ${widget.product.discountPercentage}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Text(
                '\$${widget.product.finalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: isTablet ? 30 : 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Description
          Text(
            widget.product.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 28),

          // Features
          const Text(
            'Key Features:',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...widget.product.features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(feature, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Stock
          Row(
            children: [
              Icon(
                widget.product.stock > 10 ? Icons.check_circle : Icons.warning,
                color: widget.product.stock > 10
                    ? AppColors.success
                    : AppColors.warning,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                widget.product.stock > 10
                    ? 'In Stock'
                    : 'Only ${widget.product.stock} left',
                style: TextStyle(
                  color: widget.product.stock > 10
                      ? AppColors.success
                      : AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Quantity
          const Text(
            'Quantity:',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildQuantityButton(
                Icons.remove,
                _quantity > 1 ? () => setState(() => _quantity--) : null,
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildQuantityButton(
                Icons.add,
                _quantity < widget.product.stock
                    ? () => setState(() => _quantity++)
                    : null,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _cart.add({
                        'product': widget.product,
                        'quantity': _quantity,
                      });
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added $_quantity item(s) of "${widget.product.name}" to demo cart',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                iconSize: 26,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback? onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Product Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (widget.product.specifications != null)
                ...widget.product.specifications!.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 160,
                          child: Text(
                            '${entry.key}:',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        Flexible(child: Text(entry.value.toString())),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
