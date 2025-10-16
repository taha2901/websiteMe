import 'package:flutter/material.dart';
import 'package:websiteme/screens/dashboard/orders_section.dart';
import 'package:websiteme/screens/dashboard/products_section.dart';
import 'package:websiteme/screens/dashboard/reports_section.dart';
import 'package:websiteme/screens/dashboard/users_section.dart';
import '../../widgets/navbar.dart';
import '../../widgets/footer.dart';
import '../../core/constants/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(Icons.dashboard_outlined, 'Overview'),
    _NavItem(Icons.shopping_bag_outlined, 'Products'),
    _NavItem(Icons.receipt_outlined, 'Orders'),
    _NavItem(Icons.people_outlined, 'Users'),
    _NavItem(Icons.bar_chart_outlined, 'Analytics'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1100;

    return Scaffold(
      appBar: const Navbar(),
      drawer: !isDesktop ? _buildDrawer() : null,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                if (isDesktop) _buildSidebar(),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
          // const Footer(),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          right: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              itemBuilder: (context, index) {
                final item = _navItems[index];
                final isSelected = index == _selectedIndex;

                return ListTile(
                  leading: Icon(
                    item.icon,
                    color:
                        isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      color:
                          isSelected ? AppColors.primary : AppColors.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor: AppColors.primary.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () => setState(() => _selectedIndex = index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.admin_panel_settings, color: Colors.white, size: 50),
                  SizedBox(height: 12),
                  Text(
                    'Admin Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              itemBuilder: (context, index) {
                final item = _navItems[index];
                final isSelected = index == _selectedIndex;

                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.label),
                  selected: isSelected,
                  onTap: () {
                    setState(() => _selectedIndex = index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const _DashboardOverview();
      case 1:
        return const ProductsManagementScreen();
      case 2:
        return const OrdersManagementScreen();
      case 3:
        return const UsersManagementScreen();
      case 4:
        return const AnalyticsScreen();
      default:
        return const _DashboardOverview();
    }
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

/// ==================== DASHBOARD OVERVIEW ====================

class _DashboardOverview extends StatelessWidget {
  const _DashboardOverview();

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard Overview',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Welcome back! Here\'s what\'s happening',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add Product'),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Stats Cards
          GridView.count(
            crossAxisCount: isDesktop ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.5,
            children: const [
              _StatCard(
                title: 'Total Revenue',
                value: '\$48,352',
                icon: Icons.attach_money,
                color: AppColors.success,
                trend: '+12.5%',
              ),
              _StatCard(
                title: 'Total Orders',
                value: '1,234',
                icon: Icons.shopping_cart,
                color: AppColors.primary,
                trend: '+8.2%',
              ),
              _StatCard(
                title: 'Total Products',
                value: '456',
                icon: Icons.inventory_2,
                color: AppColors.secondary,
                trend: '+3.1%',
              ),
              _StatCard(
                title: 'Total Users',
                value: '8,942',
                icon: Icons.people,
                color: AppColors.accent,
                trend: '+15.3%',
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Quick Stats Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Stats',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildQuickStat('Pending Orders', '23', Icons.pending),
                  const SizedBox(height: 16),
                  _buildQuickStat('Low Stock Items', '8', Icons.warning),
                  const SizedBox(height: 16),
                  _buildQuickStat('New Users Today', '47', Icons.person_add),
                  const SizedBox(height: 16),
                  _buildQuickStat('Total Reviews', '312', Icons.star),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Recent Orders Section
          const Text(
            'Recent Orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildOrdersList(),
        ],
      ),
    );
  }

  static Widget _buildOrdersList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.shopping_bag, color: AppColors.primary),
          ),
          title: Text('Order #${1000 + index}'),
          subtitle: Text('Customer ${index + 1}'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${(50 + index * 20).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Completed',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildQuickStat(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    trend,
                    style: const TextStyle(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
