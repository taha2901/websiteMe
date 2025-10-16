import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/navbar.dart';
import '../../widgets/footer.dart';
import '../../providers/auth_provider.dart';
import '../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    if (user == null) {
      // 🔒 حالة المستخدم غير مسجل الدخول
      return const Scaffold(
        body: Center(
          child: Text('Please log in to view your profile.'),
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1000;
    final bool isTablet = width >= 700 && width < 1000;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const Navbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 900),
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 48 : 24,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🧍‍♂️ Profile Header
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isHorizontal = constraints.maxWidth > 500;
                              return isHorizontal
                                  ? Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        _buildAvatar(user.name),
                                        const SizedBox(width: 24),
                                        Expanded(child: _buildUserInfo(user)),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/edit-profile');
                                          },
                                          icon: const Icon(Icons.edit),
                                          label: const Text('Edit Profile'),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        _buildAvatar(user.name),
                                        const SizedBox(height: 16),
                                        _buildUserInfo(user),
                                        const SizedBox(height: 16),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/edit-profile');
                                          },
                                          icon: const Icon(Icons.edit),
                                          label: const Text('Edit Profile'),
                                        ),
                                      ],
                                    );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ⚙️ Menu Options
                      _buildMenuItem(
                        context,
                        Icons.receipt_long,
                        'My Orders',
                        'View your order history',
                        () => Navigator.pushNamed(context, '/orders'),
                      ),
                      _buildMenuItem(
                        context,
                        Icons.location_on_outlined,
                        'Addresses',
                        'Manage your shipping addresses',
                        () {},
                      ),
                      _buildMenuItem(
                        context,
                        Icons.payment_outlined,
                        'Payment Methods',
                        'Manage your payment options',
                        () {},
                      ),
                      _buildMenuItem(
                        context,
                        Icons.notifications_outlined,
                        'Notifications',
                        'Manage your notifications',
                        () {},
                      ),
                      _buildMenuItem(
                        context,
                        Icons.help_outline,
                        'Help & Support',
                        'Get help with your orders',
                        () {},
                      ),
                      // if (user.isAdmin)
                        _buildMenuItem(
                          context,
                          Icons.dashboard_outlined,
                          'Admin Dashboard',
                          'Manage your store',
                          () => Navigator.pushNamed(context, '/dashboard'),
                          isHighlighted: true,
                        ),

                      const SizedBox(height: 32),

                      // 🚪 Logout Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            authProvider.logout();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                              (route) => false,
                            );
                          },
                          icon: const Icon(Icons.logout),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text('Logout'),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // const Footer(),
        ],
      ),
    );
  }

  // 🧩 مكونات الواجهة

  Widget _buildAvatar(String name) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.primary.withOpacity(0.15),
      child: Text(
        name[0].toUpperCase(),
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildUserInfo(user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          user.email,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
        if (user.phone != null) ...[
          const SizedBox(height: 4),
          Text(
            user.phone!,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isHighlighted = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isHighlighted ? AppColors.primary.withOpacity(0.05) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHighlighted
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isHighlighted ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isHighlighted ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
