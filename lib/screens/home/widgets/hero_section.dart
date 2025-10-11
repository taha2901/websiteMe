import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1000;
    final bool isDesktop = width >= 1000;

    // ارتفاع مرن حسب نوع الجهاز
    final double sectionHeight = isDesktop
        ? 520
        : isTablet
            ? 450
            : 380;

    // حجم النصوص والأزرار متناسب مع الشاشة
    final double titleSize = isDesktop
        ? 54.sp
        : isTablet
            ? 40.sp
            : 28.sp;

    final double subtitleSize = isDesktop
        ? 20.sp
        : isTablet
            ? 18.sp
            : 15.sp;

    final double buttonPadding = isMobile ? 14 : 18;
    final double buttonFont = isMobile ? 14 : 16;

    return Container(
      width: double.infinity,
      height: sectionHeight.h,
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
          // خلفية شفافة ناعمة (pattern)
          Opacity(
            opacity: 0.15,
            child: Image.network(
              'https://picsum.photos/1920/1080',
              fit: BoxFit.cover,
            ),
          ),

          // المحتوى
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
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
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // العنوان الفرعي
                    Text(
                      'Discover premium products at unbeatable prices',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: subtitleSize,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // الأزرار
                    Wrap(
                      spacing: 16.w,
                      runSpacing: 10.h,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/products'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32.w,
                              vertical: buttonPadding.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Shop Now',
                            style: TextStyle(
                              fontSize: buttonFont.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white, width: 2),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32.w,
                              vertical: buttonPadding.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Learn More',
                            style: TextStyle(
                              fontSize: buttonFont.sp,
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
  }
}
