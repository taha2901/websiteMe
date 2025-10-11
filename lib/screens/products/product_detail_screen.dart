// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/product.dart';
// import '../../widgets/navbar.dart';
// import '../../widgets/footer.dart';
// import '../../providers/cart_provider.dart';
// import '../../core/constants/app_colors.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final Product product;

//   const ProductDetailScreen({super.key, required this.product});

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   int _selectedImageIndex = 0;
//   int _quantity = 1;

//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = MediaQuery.of(context).size.width >= 900;

//     return Scaffold(
//       appBar: const Navbar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               constraints: const BoxConstraints(maxWidth: 1200),
//               padding: const EdgeInsets.all(24),
//               child: isDesktop
//                   ? Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(flex: 1, child: _buildImageGallery()),
//                         const SizedBox(width: 48),
//                         Expanded(flex: 1, child: _buildProductInfo()),
//                       ],
//                     )
//                   : Column(
//                       children: [
//                         _buildImageGallery(),
//                         const SizedBox(height: 24),
//                         _buildProductInfo(),
//                       ],
//                     ),
//             ),
//             const SizedBox(height: 40),
//             _buildProductDetails(),
//             const SizedBox(height: 60),
//             const Footer(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageGallery() {
//     return Column(
//       children: [
//         Container(
//           height: 500,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: AppColors.border),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Image.network(
//               widget.product.images[_selectedImageIndex],
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 80,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: widget.product.images.length,
//             itemBuilder: (context, index) {
//               final isSelected = index == _selectedImageIndex;
//               return GestureDetector(
//                 onTap: () => setState(() => _selectedImageIndex = index),
//                 child: Container(
//                   width: 80,
//                   margin: const EdgeInsets.only(right: 12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                       color: isSelected ? AppColors.primary : AppColors.border,
//                       width: isSelected ? 3 : 1,
//                     ),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       widget.product.images[index],
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProductInfo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Breadcrumb
//         Text(
//           widget.product.category,
//           style: const TextStyle(
//             color: AppColors.primary,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         // Product Name
//         Text(
//           widget.product.name,
//           style: const TextStyle(
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         // Rating
//         Row(
//           children: [
//             ...List.generate(5, (index) {
//               return Icon(
//                 index < widget.product.rating.floor()
//                     ? Icons.star
//                     : Icons.star_border,
//                 color: Colors.amber,
//                 size: 24,
//               );
//             }),
//             const SizedBox(width: 8),
//             Text(
//               '${widget.product.rating} (${widget.product.reviewsCount} reviews)',
//               style: const TextStyle(
//                 color: AppColors.textSecondary,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//         // Price
//         Row(
//           children: [
//             if (widget.product.isOnSale) ...[
//               Text(
//                 '\${widget.product.price.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   decoration: TextDecoration.lineThrough,
//                   color: AppColors.textLight,
//                   fontSize: 20,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: AppColors.error,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   'Save ${widget.product.discountPercentage}%',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//             ],
//             Text(
//               '\${widget.product.finalPrice.toStringAsFixed(2)}',
//               style: const TextStyle(
//                 fontSize: 36,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.primary,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//         // Description
//         Text(
//           widget.product.description,
//           style: const TextStyle(
//             fontSize: 16,
//             height: 1.6,
//             color: AppColors.textSecondary,
//           ),
//         ),
//         const SizedBox(height: 32),
//         // Features
//         const Text(
//           'Key Features:',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         ...widget.product.features.map((feature) => Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: Row(
//                 children: [
//                   const Icon(Icons.check_circle, 
//                        color: AppColors.success, size: 20),
//                   const SizedBox(width: 8),
//                   Text(feature, style: const TextStyle(fontSize: 15)),
//                 ],
//               ),
//             )),
//         const SizedBox(height: 32),
//         // Stock Status
//         Row(
//           children: [
//             Icon(
//               widget.product.stock > 10
//                   ? Icons.check_circle
//                   : Icons.warning,
//               color: widget.product.stock > 10
//                   ? AppColors.success
//                   : AppColors.warning,
//               size: 20,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               widget.product.stock > 10
//                   ? 'In Stock'
//                   : 'Only ${widget.product.stock} left',
//               style: TextStyle(
//                 color: widget.product.stock > 10
//                     ? AppColors.success
//                     : AppColors.warning,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 32),
//         // Quantity Selector
//         const Text(
//           'Quantity:',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             IconButton(
//               onPressed: _quantity > 1
//                   ? () => setState(() => _quantity--)
//                   : null,
//               icon: const Icon(Icons.remove),
//               style: IconButton.styleFrom(
//                 backgroundColor: AppColors.background,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   side: const BorderSide(color: AppColors.border),
//                 ),
//               ),
//             ),
//             Container(
//               width: 60,
//               alignment: Alignment.center,
//               child: Text(
//                 '$_quantity',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             IconButton(
//               onPressed: _quantity < widget.product.stock
//                   ? () => setState(() => _quantity++)
//                   : null,
//               icon: const Icon(Icons.add),
//               style: IconButton.styleFrom(
//                 backgroundColor: AppColors.background,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   side: const BorderSide(color: AppColors.border),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 32),
//         // Action Buttons
//         Row(
//           children: [
//             Expanded(
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   for (int i = 0; i < _quantity; i++) {
//                     context.read<CartProvider>().addToCart(widget.product);
//                   }
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Added $_quantity item(s) to cart'),
//                       action: SnackBarAction(
//                         label: 'View Cart',
//                         onPressed: () => Navigator.pushNamed(context, '/cart'),
//                       ),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.shopping_cart),
//                 label: const Text('Add to Cart'),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.favorite_border),
//               iconSize: 28,
//               style: IconButton.styleFrom(
//                 backgroundColor: AppColors.background,
//                 padding: const EdgeInsets.all(16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   side: const BorderSide(color: AppColors.border),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildProductDetails() {
//     return Container(
//       color: AppColors.background,
//       padding: const EdgeInsets.all(48),
//       child: Container(
//         constraints: const BoxConstraints(maxWidth: 1200),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Product Details',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 24),
//             if (widget.product.specifications != null)
//               ...widget.product.specifications!.entries.map((entry) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 12),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 200,
//                         child: Text(
//                           '${entry.key}:',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.textSecondary,
//                           ),
//                         ),
//                       ),
//                       Text(entry.value.toString()),
//                     ],
//                   ),
//                 );
//               }),
//           ],
//         ),
//       ),
//     );
//   }
// }


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
  final List<Map<String, dynamic>> _cart = []; // سلة محلية مؤقتة

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: const Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.all(24),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _buildImageGallery()),
                        const SizedBox(width: 48),
                        Expanded(flex: 1, child: _buildProductInfo()),
                      ],
                    )
                  : Column(
                      children: [
                        _buildImageGallery(),
                        const SizedBox(height: 24),
                        _buildProductInfo(),
                      ],
                    ),
            ),
            const SizedBox(height: 40),
            _buildProductDetails(),
            const SizedBox(height: 60),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return Column(
      children: [
        Container(
          height: 500,
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
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.product.images.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedImageIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedImageIndex = index),
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 12),
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

  Widget _buildProductInfo() {
    return Column(
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
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ...List.generate(5, (index) {
              return Icon(
                index < widget.product.rating.floor()
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amber,
                size: 24,
              );
            }),
            const SizedBox(width: 8),
            Text(
              '${widget.product.rating} (${widget.product.reviewsCount} reviews)',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            if (widget.product.isOnSale) ...[
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.textLight,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Save ${widget.product.discountPercentage}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              '\$${widget.product.finalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          widget.product.description,
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Key Features:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...widget.product.features.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: AppColors.success, size: 20),
                  const SizedBox(width: 8),
                  Text(feature, style: const TextStyle(fontSize: 15)),
                ],
              ),
            )),
        const SizedBox(height: 32),
        Row(
          children: [
            Icon(
              widget.product.stock > 10
                  ? Icons.check_circle
                  : Icons.warning,
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
        const SizedBox(height: 32),
        const Text(
          'Quantity:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            IconButton(
              onPressed: _quantity > 1
                  ? () => setState(() => _quantity--)
                  : null,
              icon: const Icon(Icons.remove),
            ),
            Container(
              width: 60,
              alignment: Alignment.center,
              child: Text(
                '$_quantity',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: _quantity < widget.product.stock
                  ? () => setState(() => _quantity++)
                  : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 32),
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
                          'Added $_quantity item(s) of "${widget.product.name}" to demo cart'),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
              iconSize: 28,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(48),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Product Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            if (widget.product.specifications != null)
              ...widget.product.specifications!.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          '${entry.key}:',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      Text(entry.value.toString()),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
