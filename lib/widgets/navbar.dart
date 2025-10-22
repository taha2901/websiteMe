import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/logic/cubits/auth/auth_cubit.dart';
import 'package:websiteme/logic/cubits/auth/auth_state.dart';
import '../core/constants/app_colors.dart';
import 'cart_icon.dart';
import 'search_bar.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1100;
    final isTablet = width >= 700 && width < 1100;
    final isMobile = width < 700;

    // نجيب الحالة الحالية من AuthCubit
    final state = context.watch<AuthCubit>().state;

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
        if (isDesktop) ..._buildDesktopActions(context, state),
        if (isTablet) ..._buildTabletActions(context, state),
        if (isMobile) ..._buildMobileActions(context, state),
      ],
    );
  }

  // 💻 Desktop Actions
  List<Widget> _buildDesktopActions(BuildContext context, AuthState state) {
    return [
      _NavButton(label: 'Home', onTap: () => Navigator.pushNamed(context, '/')),
      _NavButton(
        label: 'Products',
        onTap: () => Navigator.pushNamed(context, '/products'),
      ),
      _NavButton(
        label: 'Categories',
        onTap: () {
          Navigator.pushNamed(context, '/categories');
        },
      ),
      _NavButton(
        label: 'favourites',
        onTap: () {
          Navigator.pushNamed(context, '/favourites');
        },
      ),
      const SizedBox(width: 16),
      const CartIcon(),
      const SizedBox(width: 16),
      _buildAuthActions(context, state),
      const SizedBox(width: 16),
    ];
  }

  // 📟 Tablet Actions
  List<Widget> _buildTabletActions(BuildContext context, AuthState state) {
    return [
      const CartIcon(),
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => _openDrawer(context, state),
      ),
    ];
  }

  // 📱 Mobile Actions
  List<Widget> _buildMobileActions(BuildContext context, AuthState state) {
    return [
      const CartIcon(),
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => _openDrawer(context, state),
      ),
    ];
  }

  // 🔐 Authenticated / Guest
  Widget _buildAuthActions(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      final user = state.user;
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
              context.read<AuthCubit>().logout();
              break;
          }
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                (user.email?.isNotEmpty ?? false)
                    ? user.email![0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              user.email ?? 'User',
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
          ],
        ),
        itemBuilder: (context) => const [
          PopupMenuItem<int>(
            value: 0,
            child: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 8),
                Text('Profile'),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                Icon(Icons.receipt),
                SizedBox(width: 8),
                Text('My Orders'),
              ],
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
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
  void _openDrawer(BuildContext context, AuthState state) {
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
            if (state is AuthAuthenticated)
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
            const Divider(),
            if (state is AuthAuthenticated)
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () => context.read<AuthCubit>().logout(),
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
