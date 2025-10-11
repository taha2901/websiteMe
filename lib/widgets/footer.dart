import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Container(
      width: double.infinity, 
      color: AppColors.textPrimary,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop
            ? 48
            : (isTablet ? 24 : 0), // 👈 بدون padding على الموبايل
        vertical: isDesktop ? 48 : 32,
      ),
      child: isDesktop
          ? _buildDesktopFooter()
          : isTablet
          ? _buildTabletFooter()
          : _buildMobileFooter(),
    );
  }

  // ----------------- Desktop Footer -----------------
  Widget _buildDesktopFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo & Description
            Expanded(flex: 2, child: _footerLogoSection()),
            const SizedBox(width: 24),
            // Footer Columns
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _footerColumn('Shop', [
                    'All Products',
                    'Categories',
                    'Deals',
                    'New Arrivals',
                  ]),
                  _footerColumn('Support', [
                    'Help Center',
                    'Track Order',
                    'Returns',
                    'Shipping',
                  ]),
                  _footerColumn('Company', [
                    'About Us',
                    'Careers',
                    'Contact',
                    'Blog',
                  ]),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Divider(color: AppColors.textLight),
        const SizedBox(height: 24),
        // Bottom Row
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '© 2025 ShopPro. All rights reserved.',
              style: TextStyle(color: AppColors.textLight, fontSize: 14),
            ),
            Row(
              children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(color: AppColors.textLight, fontSize: 14),
                ),
                SizedBox(width: 24),
                Text(
                  'Terms of Service',
                  style: TextStyle(color: AppColors.textLight, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ----------------- Tablet Footer -----------------
  Widget _buildTabletFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _footerLogoSection(),
        const SizedBox(height: 32),
        Wrap(
          spacing: 32,
          runSpacing: 24,
          children: [
            _footerColumn('Shop', [
              'All Products',
              'Categories',
              'Deals',
              'New Arrivals',
            ]),
            _footerColumn('Support', [
              'Help Center',
              'Track Order',
              'Returns',
              'Shipping',
            ]),
            _footerColumn('Company', [
              'About Us',
              'Careers',
              'Contact',
              'Blog',
            ]),
          ],
        ),
        const SizedBox(height: 32),
        const Divider(color: AppColors.textLight),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            '© 2025 ShopPro. All rights reserved.',
            style: TextStyle(color: AppColors.textLight, fontSize: 13),
          ),
        ),
      ],
    );
  }

  // ----------------- Mobile Footer -----------------
  // ----------------- Mobile Footer (محسّن) -----------------
  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo & Description
        Center(child: _footerLogoSection()),
        const SizedBox(height: 24),

        // Columns in Wrap (بدل ما تكون عمودية بالكامل)
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 40,
          runSpacing: 24,
          children: [
            _footerColumn('Shop', ['All Products', 'Categories', 'Deals']),
            _footerColumn('Support', ['Help Center', 'Track Order']),
            _footerColumn('Company', ['About Us', 'Contact']),
          ],
        ),

        const SizedBox(height: 32),
        const Divider(color: AppColors.textLight),

        // Social Media Row
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          children: [
            _socialIcon(Icons.facebook),
            _socialIcon(Icons.link),
            _socialIcon(Icons.email),
            _socialIcon(Icons.phone),
          ],
        ),

        const SizedBox(height: 16),
        const Text(
          '© 2025 ShopPro. All rights reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textLight, fontSize: 12),
        ),
      ],
    );
  }

  // ----------------- Shared Widgets -----------------
  Widget _footerLogoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
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
          style: TextStyle(color: AppColors.textLight, fontSize: 14),
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
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return SizedBox(
      width: 160,
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
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                item,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}
