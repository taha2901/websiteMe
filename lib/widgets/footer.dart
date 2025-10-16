import 'package:flutter/material.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/core/constants/app_constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.textPrimary,
      padding: Responsive.pagePadding(context),
      child: ResponsiveLayout(
        mobile: _buildMobileFooter(context),
        tablet: _buildTabletFooter(context),
        desktop: _buildDesktopFooter(context),
      ),
    );
  }

  // ---------------------- Desktop Layout ----------------------
  Widget _buildDesktopFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _footerLogoSection(context)),
            SizedBox(width: Responsive.spacing(context, 32)),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        SizedBox(height: Responsive.spacing(context, 40)),
        const Divider(color: AppColors.textLight),
        SizedBox(height: Responsive.spacing(context, 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _footerText('© 2025 ShopPro. All rights reserved.'),
            Row(
              children: [
                _footerText('Privacy Policy'),
                SizedBox(width: Responsive.spacing(context, 24)),
                _footerText('Terms of Service'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------- Tablet Layout ----------------------
  Widget _buildTabletFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _footerLogoSection(context),
        SizedBox(height: Responsive.spacing(context, 32)),
        Wrap(
          spacing: Responsive.spacing(context, 32),
          runSpacing: Responsive.spacing(context, 24),
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
        SizedBox(height: Responsive.spacing(context, 32)),
        const Divider(color: AppColors.textLight),
        SizedBox(height: Responsive.spacing(context, 16)),
        Center(child: _footerText('© 2025 ShopPro. All rights reserved.')),
      ],
    );
  }

  // ---------------------- Mobile Layout ----------------------
  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _footerLogoSection(context, isCentered: true),
        SizedBox(height: Responsive.spacing(context, 24)),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: Responsive.spacing(context, 40),
          runSpacing: Responsive.spacing(context, 24),
          children: [
            _footerColumn('Shop', ['All Products', 'Categories', 'Deals']),
            _footerColumn('Support', ['Help Center', 'Track Order']),
            _footerColumn('Company', ['About Us', 'Contact']),
          ],
        ),
        SizedBox(height: Responsive.spacing(context, 32)),
        const Divider(color: AppColors.textLight),
        SizedBox(height: Responsive.spacing(context, 16)),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: Responsive.spacing(context, 12),
          children: _socialIcons(),
        ),
        SizedBox(height: Responsive.spacing(context, 16)),
        _footerText(
          '© 2025 ShopPro. All rights reserved.',
          isCentered: true,
        ),
      ],
    );
  }

  // ---------------------- Shared Widgets ----------------------
  Widget _footerLogoSection(BuildContext context, {bool isCentered = false}) {
    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
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
        SizedBox(height: Responsive.spacing(context, 16)),
        const Text(
          'Your premium shopping destination for quality products at the best prices.',
          style: TextStyle(color: AppColors.textLight, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Responsive.spacing(context, 20)),
        if (!isCentered) Row(children: _socialIcons()),
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

  List<Widget> _socialIcons() {
    const icons = [
      Icons.facebook,
      Icons.link,
      Icons.email,
      Icons.phone,
    ];

    return icons
        .map(
          (icon) => Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
        )
        .toList();
  }

  Widget _footerText(String text, {bool isCentered = false}) {
    return Text(
      text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      style: const TextStyle(color: AppColors.textLight, fontSize: 13),
    );
  }
}
