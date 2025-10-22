import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websiteme/core/constants/app_colors.dart';
import 'package:websiteme/core/constants/app_constants.dart';
import 'package:websiteme/logic/cubits/auth/auth_cubit.dart';
import 'package:websiteme/logic/cubits/auth/auth_state.dart';
import 'package:websiteme/logic/cubits/cart/cart_cubit.dart';
import 'package:websiteme/logic/cubits/cart/cart_states.dart';
import 'package:websiteme/logic/cubits/order/order_cubit.dart';
import 'package:websiteme/logic/cubits/order/order_states.dart';
import 'package:websiteme/models/cart_item.dart';
import 'package:websiteme/widgets/navbar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String _paymentMethod = 'card';

  // بيانات العنوان
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartCubit>().state;

    // ⇢ نوع صريح: List<CartItemModel>
    final List<CartItemModel> items =
        (cartState is CartLoaded) ? cartState.items : <CartItemModel>[];

    // subtotal حساب صحيح مع نوع double
    final double subtotal = items.fold<double>(
      0.0,
      (sum, i) => sum + (i.total), // افترضنا totalPrice: double
    );
    final double shipping = subtotal > 100 ? 0.0 : 9.99;
    final double total = subtotal + shipping;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const Navbar(),
      body: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is OrderSuccess) {
            // Close loading dialog if open
            if (Navigator.canPop(context)) Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('✅ Order Placed Successfully!'),
                content: const Text('Thank you for your order.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (r) => false);
                      context.read<CartCubit>().clearCart();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state is OrderError) {
            if (Navigator.canPop(context)) Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('❌ Error: ${state.message}')),
            );
          }
        },
        child: ResponsiveLayout(
          mobile: _buildStepper(context, items, subtotal, shipping, total,
              padding: const EdgeInsets.all(16)),
          tablet: _buildStepper(context, items, subtotal, shipping, total,
              padding: const EdgeInsets.all(24)),
          desktop: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: _buildStepper(
                context,
                items,
                subtotal,
                shipping,
                total,
                padding: const EdgeInsets.all(32),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepper(
    BuildContext context,
    List<CartItemModel> items, // نوع هنا واضح
    double subtotal,
    double shipping,
    double total, {
    required EdgeInsets padding,
  }) {
    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Checkout',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  )),
          const SizedBox(height: 24),
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context)
                  .colorScheme
                  .copyWith(primary: AppColors.primary),
            ),
            child: Stepper(
              type: StepperType.vertical,
              currentStep: _currentStep,
              onStepContinue: () => _nextStep(context, items, total),
              onStepCancel: _previousStep,
              controlsBuilder: (context, details) => _buildButtons(details),
              steps: [
                Step(
                  title: const Text('Shipping Address'),
                  isActive: _currentStep >= 0,
                  content: _buildShippingForm(),
                ),
                Step(
                  title: const Text('Payment Method'),
                  isActive: _currentStep >= 1,
                  content: _buildPaymentForm(),
                ),
                Step(
                  title: const Text('Review Order'),
                  isActive: _currentStep >= 2,
                  content: _buildReview(items, subtotal, shipping, total),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(ControlsDetails details) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: details.onStepContinue,
          child: Text(_currentStep == 2 ? 'Place Order' : 'Next'),
        ),
        const SizedBox(width: 8),
        if (_currentStep > 0)
          TextButton(
            onPressed: details.onStepCancel,
            child: const Text('Back'),
          ),
      ],
    );
  }

  Widget _buildShippingForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _field(_nameController, 'Full Name'),
          const SizedBox(height: 12),
          _field(_addressController, 'Address'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _field(_cityController, 'City')),
              const SizedBox(width: 12),
              Expanded(child: _field(_postalController, 'Postal Code')),
            ],
          ),
          const SizedBox(height: 12),
          _field(_phoneController, 'Phone', keyboard: TextInputType.phone),
        ],
      ),
    );
  }

  Widget _field(TextEditingController c, String label,
      {TextInputType keyboard = TextInputType.text}) {
    return TextFormField(
      controller: c,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildPaymentForm() {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          RadioListTile(
            title: const Text('Credit/Debit Card'),
            value: 'card',
            groupValue: _paymentMethod,
            onChanged: (v) => setState(() => _paymentMethod = v!),
          ),
          const Divider(height: 0),
          RadioListTile(
            title: const Text('PayPal'),
            value: 'paypal',
            groupValue: _paymentMethod,
            onChanged: (v) => setState(() => _paymentMethod = v!),
          ),
          const Divider(height: 0),
          RadioListTile(
            title: const Text('Cash on Delivery'),
            value: 'cod',
            groupValue: _paymentMethod,
            onChanged: (v) => setState(() => _paymentMethod = v!),
          ),
        ],
      ),
    );
  }

  Widget _buildReview(List<CartItemModel> items, double subtotal, double shipping,
      double total) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          ...items.map((item) => ListTile(
                leading: Image.network(item.image, width: 50),
                title: Text(item.name),
                subtitle: Text('Qty: ${item.quantity}'),
                trailing: Text('\$${item.total.toStringAsFixed(2)}'),
              )),
          const Divider(),
          _summary('Subtotal', subtotal),
          _summary('Shipping', shipping),
          _summary('Total', total, bold: true),
        ],
      ),
    );
  }

  Widget _summary(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : null)),
          Text('\$${value.toStringAsFixed(2)}',
              style: TextStyle(
                  color: bold ? AppColors.primary : Colors.black,
                  fontWeight: bold ? FontWeight.bold : null)),
        ],
      ),
    );
  }

  void _nextStep(BuildContext context, List<CartItemModel> items, double total) {
    if (_currentStep == 0 && !_formKey.currentState!.validate()) return;

    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      final authState = context.read<AuthCubit>().state;
      if (authState is! AuthAuthenticated) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Please login first')));
        return;
      }

      final address = {
        'name': _nameController.text,
        'address': _addressController.text,
        'city': _cityController.text,
        'postal': _postalController.text,
        'phone': _phoneController.text,
      };

      // هنا النوع مضبوط: List<CartItemModel>
      context.read<OrderCubit>().placeOrder(
            userId: authState.user.uid,
            items: items,
            total: total,
            paymentMethod: _paymentMethod,
            address: address,
          );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }
}
