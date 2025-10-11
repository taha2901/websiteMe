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

    return Scaffold(
      appBar: const Navbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.primary.withOpacity(0.1),
                              child: Text(
                                user!.name[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
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
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.edit),
                              label: const Text('Edit Profile'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Menu Options
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
                    if (user.isAdmin)
                      _buildMenuItem(
                        context,
                        Icons.dashboard_outlined,
                        'Admin Dashboard',
                        'Manage your store',
                        () => Navigator.pushNamed(context, '/dashboard'),
                        isHighlighted: true,
                      ),
                    const SizedBox(height: 24),
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Footer(),
        ],
      ),
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
      color: isHighlighted ? AppColors.primary.withOpacity(0.05) : null,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHighlighted
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.background,
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
            color: isHighlighted ? AppColors.primary : null,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
