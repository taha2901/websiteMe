// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../widgets/navbar.dart';
// import '../../widgets/footer.dart';
// import '../../providers/product_provider.dart';
// import 'widgets/hero_section.dart';
// import 'widgets/categories_section.dart';
// import 'widgets/featured_products.dart';
// import 'widgets/deals_section.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() => context.read<ProductProvider>().loadProducts());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLoading = context.watch<ProductProvider>().isLoading;

//     return Scaffold(
//       appBar: const Navbar(),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : const SingleChildScrollView(
//               child: Column(
//                 children: [
//                   HeroSection(),
//                   SizedBox(height: 60),
//                   CategoriesSection(),
//                   SizedBox(height: 60),
//                   FeaturedProducts(),
//                   SizedBox(height: 60),
//                   DealsSection(),
//                   SizedBox(height: 60),
//                   Footer(),
//                 ],
//               ),
//             ),
//     );
//   }
// }



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
    return const Scaffold(
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
