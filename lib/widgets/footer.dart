import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Container(
      color: AppColors.textPrimary,
      padding: EdgeInsets.all(isDesktop ? 48 : 24),
      child: isDesktop ? _buildDesktopFooter() : _buildMobileFooter(),
    );
  }

  Widget _buildDesktopFooter() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                        child: const Icon(Icons.shopping_bag, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'ShopPro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your premium shopping destination for quality products at the best prices.',
                    style: TextStyle(color: AppColors.textLight),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _socialIcon(Icons.facebook),
                      _socialIcon(Icons.link),
                      _socialIcon(Icons.email),
                      _socialIcon(Icons.phone),
                    ],
                  ),
                ],
              ),
            ),
            _footerColumn('Shop', ['All Products', 'Categories', 'Deals', 'New Arrivals']),
            _footerColumn('Support', ['Help Center', 'Track Order', 'Returns', 'Shipping']),
            _footerColumn('Company', ['About Us', 'Careers', 'Contact', 'Blog']),
          ],
        ),
        const Divider(color: AppColors.textLight, height: 48),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('© 2025 ShopPro. All rights reserved.', 
                 style: TextStyle(color: AppColors.textLight)),
            Row(
              children: [
                Text('Privacy Policy', style: TextStyle(color: AppColors.textLight)),
                SizedBox(width: 24),
                Text('Terms of Service', style: TextStyle(color: AppColors.textLight)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ShopPro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Your premium shopping destination.',
          style: TextStyle(color: AppColors.textLight),
        ),
        const SizedBox(height: 24),
        const Text('© 2025 ShopPro. All rights reserved.',
                   style: TextStyle(color: AppColors.textLight)),
      ],
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(item, style: const TextStyle(color: AppColors.textLight)),
              )),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
