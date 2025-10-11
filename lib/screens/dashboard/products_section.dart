
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/product_provider.dart';
// import '../../core/constants/app_colors.dart';

// class ProductsManagementScreen extends StatelessWidget {
//   const ProductsManagementScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final products = context.watch<ProductProvider>().products;

//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(24),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             border: Border(bottom: BorderSide(color: AppColors.border)),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Products Management',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Manage your product inventory',
//                     style: TextStyle(color: AppColors.textSecondary),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   OutlinedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.file_download),
//                     label: const Text('Export'),
//                   ),
//                   const SizedBox(width: 12),
//                   ElevatedButton.icon(
//                     onPressed: () => _showAddProductDialog(context),
//                     icon: const Icon(Icons.add),
//                     label: const Text('Add Product'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               children: [
//                 // Search and filters
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: 'Search products...',
//                           prefixIcon: const Icon(Icons.search),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     DropdownButton<String>(
//                       value: 'All',
//                       items: const [
//                         DropdownMenuItem(value: 'All', child: Text('All Categories')),
//                         DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
//                         DropdownMenuItem(value: 'Fashion', child: Text('Fashion')),
//                       ],
//                       onChanged: (value) {},
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 // Products Table
//                 Card(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: DataTable(
//                       columns: const [
//                         DataColumn(label: Text('Product')),
//                         DataColumn(label: Text('Category')),
//                         DataColumn(label: Text('Price')),
//                         DataColumn(label: Text('Stock')),
//                         DataColumn(label: Text('Status')),
//                         DataColumn(label: Text('Actions')),
//                       ],
//                       rows: products.take(10).map((product) {
//                         return DataRow(
//                           cells: [
//                             DataCell(
//                               Row(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: Image.network(
//                                       product.image,
//                                       width: 50,
//                                       height: 50,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Text(product.name),
//                                 ],
//                               ),
//                             ),
//                             DataCell(Text(product.category)),
//                             DataCell(Text('\${product.finalPrice.toStringAsFixed(2)}')),
//                             DataCell(Text('${product.stock}')),
//                             DataCell(
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: product.stock > 10
//                                       ? AppColors.success.withOpacity(0.1)
//                                       : AppColors.warning.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Text(
//                                   product.stock > 10 ? 'In Stock' : 'Low Stock',
//                                   style: TextStyle(
//                                     color: product.stock > 10
//                                         ? AppColors.success
//                                         : AppColors.warning,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             DataCell(
//                               Row(
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.edit, size: 20),
//                                     onPressed: () {},
//                                     color: AppColors.primary,
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.delete, size: 20),
//                                     onPressed: () {},
//                                     color: AppColors.error,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showAddProductDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add New Product'),
//         content: SizedBox(
//           width: 500,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Product Name'),
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Description'),
//                   maxLines: 3,
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Price'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Stock Quantity'),
//                   keyboardType: TextInputType.number,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Product added successfully!')),
//               );
//             },
//             child: const Text('Add Product'),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/product.dart'; // علشان demoProducts و Product

class ProductsManagementScreen extends StatelessWidget {
  const ProductsManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = demoProducts; // ✅ بدل Provider

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Products Management',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Manage your product inventory',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.file_download),
                    label: const Text('Export'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => _showAddProductDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Product'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Search and filters
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: 'All',
                      items: const [
                        DropdownMenuItem(value: 'All', child: Text('All Categories')),
                        DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
                        DropdownMenuItem(value: 'Wearables', child: Text('Wearables')),
                        DropdownMenuItem(value: 'Cameras', child: Text('Cameras')),
                        DropdownMenuItem(value: 'Accessories', child: Text('Accessories')),
                      ],
                      onChanged: (value) {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Products Table
                Card(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Product')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Price')),
                        DataColumn(label: Text('Stock')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: products.map((product) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      product.image,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(product.name),
                                ],
                              ),
                            ),
                            DataCell(Text(product.category)),
                            DataCell(Text('\$${product.finalPrice.toStringAsFixed(2)}')),
                            DataCell(Text('${product.stock}')),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: product.stock > 10
                                      ? AppColors.success.withOpacity(0.1)
                                      : AppColors.warning.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  product.stock > 10 ? 'In Stock' : 'Low Stock',
                                  style: TextStyle(
                                    color: product.stock > 10
                                        ? AppColors.success
                                        : AppColors.warning,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 20),
                                    onPressed: () {},
                                    color: AppColors.primary,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20),
                                    onPressed: () {},
                                    color: AppColors.error,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Product'),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Stock Quantity'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product added successfully!')),
              );
            },
            child: const Text('Add Product'),
          ),
        ],
      ),
    );
  }
}
