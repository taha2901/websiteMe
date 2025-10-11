import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/product.dart'; // علشان demoProducts و Product

class ProductsManagementScreen extends StatefulWidget {
  const ProductsManagementScreen({super.key});

  @override
  State<ProductsManagementScreen> createState() =>
      _ProductsManagementScreenState();
}

class _ProductsManagementScreenState extends State<ProductsManagementScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final products = demoProducts; // ✅ بدل Provider

    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: Container(
            color: Colors.grey.shade50,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildFilters(),
                  const SizedBox(height: 24),
                  _buildProductsTable(products),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Header Section
  Widget _buildHeader(BuildContext context) {
    return Container(
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
    );
  }

  // 🔹 Search + Filter
  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All Categories')),
                DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
                DropdownMenuItem(value: 'Wearables', child: Text('Wearables')),
                DropdownMenuItem(value: 'Cameras', child: Text('Cameras')),
                DropdownMenuItem(value: 'Accessories', child: Text('Accessories')),
              ],
              onChanged: (value) {
                setState(() => _selectedCategory = value!);
              },
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Data Table
  Widget _buildProductsTable(List<Product> products) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(AppColors.primary.withOpacity(0.1)),
          columns: const [
            DataColumn(label: Text('Product')),
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Stock')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: List.generate(products.length, (index) {
            final product = products[index];
            final isLowStock = product.stock <= 10;
            final bgColor = index.isEven
                ? Colors.grey.shade50
                : Colors.white;

            return DataRow(
              color: MaterialStateProperty.all(bgColor),
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
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                DataCell(Text(product.category)),
                DataCell(Text('\$${product.finalPrice.toStringAsFixed(2)}')),
                DataCell(Text('${product.stock}')),
                DataCell(_buildStatusChip(product)),
                DataCell(Row(
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
                )),
              ],
            );
          }),
        ),
      ),
    );
  }

  // 🔹 Stock Status Chip
  Widget _buildStatusChip(Product product) {
    final bool isLowStock = product.stock <= 10;
    final bool isOnSale = product.isOnSale;

    Color color;
    String label;

    if (isLowStock) {
      color = AppColors.warning;
      label = 'Low Stock';
    } else if (isOnSale) {
      color = AppColors.primary;
      label = 'On Sale';
    } else {
      color = AppColors.success;
      label = 'In Stock';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // 🔹 Add Product Dialog
  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Add New Product'),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: stockController,
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
              if (nameController.text.isEmpty ||
                  priceController.text.isEmpty ||
                  stockController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${nameController.text} added successfully!',
                  ),
                ),
              );
            },
            child: const Text('Add Product'),
          ),
        ],
      ),
    );
  }
}
