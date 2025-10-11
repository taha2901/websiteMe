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
    final isDesktop = MediaQuery.of(context).size.width >= 1100;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          // Logo
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
                const Text(
                  'ShopPro',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop) ...[
            const SizedBox(width: 40),
            const Expanded(child: CustomSearchBar()),
          ],
        ],
      ),
      actions: [
        if (isDesktop) ..._buildDesktopActions(context, authProvider),
        if (!isDesktop) ..._buildMobileActions(context),
      ],
    );
  }

  List<Widget> _buildDesktopActions(
    BuildContext context,
    AuthProvider authProvider,
  ) {
    return [
      _NavButton(label: 'Home', onTap: () => Navigator.pushNamed(context, '/')),
      _NavButton(
        label: 'Products',
        onTap: () => Navigator.pushNamed(context, '/products'),
      ),
      _NavButton(label: 'Categories', onTap: () {}),
      _NavButton(label: 'Deals', onTap: () {}),
      const SizedBox(width: 16),
      const CartIcon(),
      const SizedBox(width: 16),
      if (authProvider.isAuthenticated) ...[
        PopupMenuButton<int>(
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
            PopupMenuItem<int>(
              value: 0,
              child: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('Profile'),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: const Row(
                children: [
                  Icon(Icons.receipt),
                  SizedBox(width: 8),
                  Text('My Orders'),
                ],
              ),
            ),
            if (authProvider.isAdmin)
              PopupMenuItem<int>(
                value: 2,
                child: const Row(
                  children: [
                    Icon(Icons.dashboard),
                    SizedBox(width: 8),
                    Text('Dashboard'),
                  ],
                ),
              ),
            const PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 3,
              child: const Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
          ],
        ),
      ] else ...[
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
      const SizedBox(width: 16),
    ];
  }

  List<Widget> _buildMobileActions(BuildContext context) {
    return [
      const CartIcon(),
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openEndDrawer(),
      ),
    ];
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
