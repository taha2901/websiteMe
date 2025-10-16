import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../providers/auth_provider.dart';
import 'cart_icon.dart';
import 'search_bar.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1100;
    final isTablet = width >= 700 && width < 1100;
    final isMobile = width < 700;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          // 🛍️ Logo
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/'),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'ShopPro',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 18 : 24,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop || isTablet) ...[
            const SizedBox(width: 40),
            const Expanded(child: CustomSearchBar()),
          ],
        ],
      ),
      actions: [
        if (isDesktop) ..._buildDesktopActions(context, authProvider),
        if (isTablet) ..._buildTabletActions(context, authProvider),
        if (isMobile) ..._buildMobileActions(context),
      ],
    );
  }

  // 💻 Desktop Actions
  List<Widget> _buildDesktopActions(
    BuildContext context,
    AuthProvider authProvider,
  ) {
    return [
      _NavButton(label: 'Home', onTap: () => Navigator.pushNamed(context, '/')),
      _NavButton(
          label: 'Products', onTap: () => Navigator.pushNamed(context, '/products')),
      _NavButton(label: 'Categories', onTap: () {}),
      _NavButton(label: 'Deals', onTap: () {}),
      const SizedBox(width: 16),
      const CartIcon(),
      const SizedBox(width: 16),
      _buildAuthActions(context, authProvider),
      const SizedBox(width: 16),
    ];
  }

  // 📟 Tablet Actions (مختصرة)
  List<Widget> _buildTabletActions(
    BuildContext context,
    AuthProvider authProvider,
  ) {
    return [
      const CartIcon(),
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => _openDrawer(context, authProvider),
      ),
    ];
  }

  // 📱 Mobile Actions
  List<Widget> _buildMobileActions(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return [
      const CartIcon(),
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => _openDrawer(context, authProvider),
      ),
    ];
  }

  // 🔐 Authenticated / Guest
  Widget _buildAuthActions(BuildContext context, AuthProvider authProvider) {
    if (authProvider.isAuthenticated) {
      return PopupMenuButton<int>(
        onSelected: (value) {
          switch (value) {
            case 0:
              Navigator.pushNamed(context, '/profile');
              break;
            case 1:
              Navigator.pushNamed(context, '/orders');
              break;
            case 2:
              Navigator.pushNamed(context, '/dashboard');
              break;
            case 3:
              authProvider.logout();
              break;
          }
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                authProvider.currentUser!.name[0].toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              authProvider.currentUser!.name,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
          ],
        ),
        itemBuilder: (context) => [
          const PopupMenuItem<int>(
            value: 0,
            child: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 8),
                Text('Profile'),
              ],
            ),
          ),
          const PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                Icon(Icons.receipt),
                SizedBox(width: 8),
                Text('My Orders'),
              ],
            ),
          ),
          if (authProvider.isAdmin)
            const PopupMenuItem<int>(
              value: 2,
              child: Row(
                children: [
                  Icon(Icons.dashboard),
                  SizedBox(width: 8),
                  Text('Dashboard'),
                ],
              ),
            ),
          const PopupMenuDivider(),
          const PopupMenuItem<int>(
            value: 3,
            child: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 8),
                Text('Logout'),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            icon: const Icon(Icons.login),
            label: const Text('Login'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: const Text('Sign Up'),
          ),
        ],
      );
    }
  }

  // 📂 Drawer (للتابلت والموبايل)
  void _openDrawer(BuildContext context, AuthProvider authProvider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pushNamed(context, '/'),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Products'),
              onTap: () => Navigator.pushNamed(context, '/products'),
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('Deals'),
              onTap: () {},
            ),
            if (authProvider.isAuthenticated)
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
            const Divider(),
            if (authProvider.isAuthenticated)
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () => authProvider.logout(),
              )
            else
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Login'),
                onTap: () => Navigator.pushNamed(context, '/login'),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
