import 'package:flutter/material.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/core/constants/app_constants.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // حساب الارتفاع بناءً على حجم الشاشة
        final height = Responsive.value(
          context: context,
          mobile: 400.0,
          tablet: 500.0,
          desktop: 600.0,
        );

        return Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.9),
                AppColors.secondary.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // خلفية شفافة
              Opacity(
                opacity: 0.15,
                child: Image.network(
                  'https://picsum.photos/1920/1080',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.black12);
                  },
                ),
              ),

              // المحتوى
              Center(
                child: Padding(
                  padding: Responsive.pagePadding(context),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // العنوان الرئيسي
                        Text(
                          'Welcome to ShopPro',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.value(
                              context: context,
                              mobile: 28.0,
                              tablet: 40.0,
                              desktop: 54.0,
                            ),
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(
                          height: Responsive.spacing(context, 20),
                        ),

                        // العنوان الفرعي
                        Text(
                          'Discover premium products at unbeatable prices',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: Responsive.value(
                              context: context,
                              mobile: 14.0,
                              tablet: 18.0,
                              desktop: 20.0,
                            ),
                            height: 1.4,
                          ),
                        ),
                        SizedBox(
                          height: Responsive.spacing(context, 32),
                        ),

                        // الأزرار
                        Wrap(
                          spacing: 16,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/products'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.value(
                                    context: context,
                                    mobile: 24.0,
                                    tablet: 32.0,
                                    desktop: 40.0,
                                  ),
                                  vertical: Responsive.value(
                                    context: context,
                                    mobile: 14.0,
                                    tablet: 16.0,
                                    desktop: 18.0,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Shop Now',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 2),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.value(
                                    context: context,
                                    mobile: 24.0,
                                    tablet: 32.0,
                                    desktop: 40.0,
                                  ),
                                  vertical: Responsive.value(
                                    context: context,
                                    mobile: 14.0,
                                    tablet: 16.0,
                                    desktop: 18.0,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Learn More',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}