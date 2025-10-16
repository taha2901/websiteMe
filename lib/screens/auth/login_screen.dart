import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import '../../providers/auth_provider.dart';
import '../../core/constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        padding: Responsive.pagePadding(context),
        child: ResponsiveLayout(
          mobile: _buildLoginCard(context, maxWidth: 400),
          tablet: _buildLoginCard(context, maxWidth: 600),
          desktop: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(
                    Responsive.spacing(context, 32),
                  ),
                  child: _buildLoginCard(context, maxWidth: 600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context, {double maxWidth = 500}) {
    final authProvider = context.watch<AuthProvider>();
    final double spacing = Responsive.spacing(context, 20);
    final double titleSize = Responsive.fontSize(context, 28);

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: EdgeInsets.all(Responsive.spacing(context, 24)),
        margin: EdgeInsets.symmetric(
          vertical: Responsive.spacing(context, 40),
          horizontal: Responsive.spacing(context, 16),
        ),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(Responsive.spacing(context, 32)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.shopping_bag,
                        color: Colors.white, size: 32),
                  ),
                  SizedBox(height: spacing),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 8)),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 16),
                      color: AppColors.textLight,
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 32)),
                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: spacing),
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Responsive.spacing(context, 12)),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 24)),
                  // Login Button
                  ElevatedButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await authProvider.login(
                                _emailController.text,
                                _passwordController.text,
                              );
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(context, '/');
                              }
                            }
                          },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.spacing(context, 16),
                      ),
                      child: authProvider.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Login',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(context, 16),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: Responsive.spacing(context, 24)),
                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/register'),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
