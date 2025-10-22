import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/logic/cubits/auth/auth_cubit.dart';
import 'package:websiteme/logic/cubits/auth/auth_state.dart';
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
                  padding: EdgeInsets.all(Responsive.spacing(context, 32)),
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
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  Navigator.pushReplacementNamed(context, '/');
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
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
                      child: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 32,
                      ),
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
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        }
                      },
                      child: BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          }
                          return const Text('Login');
                        },
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
      ),
    );
  }
}
