import 'package:flutter/material.dart';
import 'package:websiteme/models/cart_item.dart';
import '../../widgets/navbar.dart';
import '../../widgets/footer.dart';
import '../../core/constants/app_colors.dart';
import '../../models/product.dart'; // فيها demoCart

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String _paymentMethod = 'card';

  double get subtotal =>
      demoCart.fold(0, (sum, item) => sum + item.totalPrice);
  double get shipping => subtotal > 100 ? 0 : 9.99;
  double get total => subtotal + shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Stepper(
                      currentStep: _currentStep,
                      onStepContinue: () {
                        if (_currentStep < 2) {
                          setState(() => _currentStep++);
                        } else {
                          _placeOrder(context);
                        }
                      },
                      onStepCancel: () {
                        if (_currentStep > 0) {
                          setState(() => _currentStep--);
                        }
                      },
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
                          content: _buildOrderReview(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }

  Widget _buildShippingForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Address'),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Postal Code'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Phone Number'),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Column(
      children: [
        RadioListTile(
          title: const Text('Credit/Debit Card'),
          value: 'card',
          groupValue: _paymentMethod,
          onChanged: (value) => setState(() => _paymentMethod = value!),
        ),
        RadioListTile(
          title: const Text('PayPal'),
          value: 'paypal',
          groupValue: _paymentMethod,
          onChanged: (value) => setState(() => _paymentMethod = value!),
        ),
        RadioListTile(
          title: const Text('Cash on Delivery'),
          value: 'cod',
          groupValue: _paymentMethod,
          onChanged: (value) => setState(() => _paymentMethod = value!),
        ),
      ],
    );
  }

  Widget _buildOrderReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Items',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...demoCart.map((item) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(item.product.name),
            subtitle: Text('Qty: ${item.quantity}'),
            trailing: Text(
              '\$${item.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }),
        const Divider(height: 32),
        _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
        const SizedBox(height: 8),
        _summaryRow('Shipping', '\$${shipping.toStringAsFixed(2)}'),
        const Divider(height: 24),
        _summaryRow('Total', '\$${total.toStringAsFixed(2)}', isTotal: true),
      ],
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  void _placeOrder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed Successfully!'),
        content: const Text(
          'Thank you for your order. You will receive a confirmation email shortly.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
