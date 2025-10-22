import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:websiteme/core/services/auth_service.dart';
import 'package:websiteme/core/services/cart_service.dart';
import 'package:websiteme/core/services/categories_services.dart';
import 'package:websiteme/core/services/favourite_services.dart';
import 'package:websiteme/core/services/order_service.dart';
import 'package:websiteme/core/services/product_details_services.dart';
import 'package:websiteme/logic/cubits/auth/auth_cubit.dart';
import 'package:websiteme/logic/cubits/auth/auth_state.dart';
import 'package:websiteme/logic/cubits/cart/cart_cubit.dart';
import 'package:websiteme/logic/cubits/category/categories_cubit.dart';
import 'package:websiteme/logic/cubits/favourite/fav_cubit.dart';
import 'package:websiteme/logic/cubits/order/order_cubit.dart';
import 'package:websiteme/logic/cubits/products/products_cubit.dart';
import 'package:websiteme/models/product.dart';
import 'package:websiteme/screens/category/category_screen.dart';
import 'package:websiteme/screens/favourite/fav_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/products/products_screen.dart';
import 'screens/products/product_detail_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/cart/checkout_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/orders_history_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'core/constants/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // 🧩 استدعاء رفع البيانات لمرة واحدة فقط
  // final seeder = FirestoreSeeder();
  // await seeder.uploadDemoProducts();
  // await seeder.uploadDemoCategories();
  final authService = AuthServicesImpl();
  final authCubit = AuthCubit(authService);
  authCubit.checkAuthState();
  runApp(MyApp(authCubit: authCubit));
}

class MyApp extends StatelessWidget {
  final AuthCubit authCubit;
  const MyApp({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider.value(value: authCubit), // ✅ مستخدم حالي محفوظ
        BlocProvider<FavouriteCubit>(
          create: (context) {
            final authState = context.read<AuthCubit>().state;
            final favService = FavouriteServicesImpl();
            if (authState is AuthAuthenticated) {
              final userId = authState.user.uid;
              final favCubit = FavouriteCubit(favService, userId);
              favCubit.loadFavourites();
              return favCubit;
            } else {
              // مستخدم مش داخل حالياً
              return FavouriteCubit(favService, '');
            }
          },
        ),
        BlocProvider(
          create: (context) {
            final authState = context.read<AuthCubit>().state;
            final cartService = CartServicesImpl();

            if (authState is AuthAuthenticated) {
              final userId = authState.user.uid;
              final cartCubit = CartCubit(cartService, userId);
              cartCubit.loadCart();
              return cartCubit;
            } else {
              return CartCubit(cartService, '');
            }
          },
        ),

        BlocProvider(
          create: (_) =>
              ProductCubit(ProductServicesImpl())..fetchAllProducts(),
        ),
        BlocProvider(
          create: (_) =>
              CategoryCubit(CategoryServicesImpl())..fetchAllCategories(),
        ),
        BlocProvider(create: (_) => OrderCubit(OrderServicesImpl())),
      ],
      child: MaterialApp(
        title: 'ShopPro - Premium E-Commerce',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: AppColors.primary,
          useMaterial3: true,
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/products': (context) => const ProductsScreen(),
          '/categories': (context) => CategoriesPage(),
          '/favourites': (context) => const FavouritePage(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/profile': (context) => const ProfileScreen(),
          // '/orders': (context) => const OrdersHistoryScreen(),
          '/dashboard': (context) => const DashboardScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/product-detail') {
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            );
          }
          return null;
        },
      ),
    );
  }
}


// npm install firebase
// 1:916458160199:web:397806d50e63a4f6fcf162
/*
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyD7IW8xBKXZhmz8vKlwtku87dQsTktOaGg",
  authDomain: "websiteone-dde44.firebaseapp.com",
  projectId: "websiteone-dde44",
  storageBucket: "websiteone-dde44.firebasestorage.app",
  messagingSenderId: "916458160199",
  appId: "1:916458160199:web:397806d50e63a4f6fcf162",
  measurementId: "G-V1L74KZ60D"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
*/