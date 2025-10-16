  import 'package:flutter/material.dart';
  import '../../widgets/navbar.dart';
  import '../../widgets/footer.dart';
  import 'widgets/hero_section.dart';
  import 'widgets/categories_section.dart';
  import 'widgets/featured_products.dart';
  import 'widgets/deals_section.dart';

  class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return  Scaffold(
        appBar: Navbar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeroSection(),
              SizedBox(height: 60),
              CategoriesSection(),
              SizedBox(height: 60),
              FeaturedProducts(),
              SizedBox(height: 60),
              DealsSection(),
              SizedBox(height: 60),
              Footer(),
            ],
          ),
        ),
      );
    }
  }
