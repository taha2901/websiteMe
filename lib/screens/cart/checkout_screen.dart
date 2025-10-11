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

  double get subtotal => demoCart.fold(0, (sum, item) => sum + item.totalPrice);
  double get shipping => subtotal > 100 ? 0 : 9.99;
  double get total => subtotal + shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
                    Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context)
                            .colorScheme
                            .copyWith(primary: AppColors.primary),
                      ),
                      child: Stepper(
                        elevation: 0,
                        type: StepperType.vertical,
                        currentStep: _currentStep,
                        onStepContinue: _nextStep,
                        onStepCancel: _previousStep,
                        controlsBuilder: (context, details) {
                          return Row(
                            children: [
                              ElevatedButton(
                                onPressed: details.onStepContinue,
                                child: Text(_currentStep == 2 ? 'Place Order' : 'Next'),
                              ),
                              const SizedBox(width: 16),
                              if (_currentStep > 0)
                                TextButton(
                                  onPressed: details.onStepCancel,
                                  child: const Text('Back'),
                                ),
                            ],
                          );
                        },
                        steps: [
                          Step(
                            title: const Text('Shipping Address'),
                            isActive: _currentStep >= 0,
                            state: _currentStep > 0
                                ? StepState.complete
                                : StepState.indexed,
                            content: _buildShippingForm(),
                          ),
                          Step(
                            title: const Text('Payment Method'),
                            isActive: _currentStep >= 1,
                            state: _currentStep > 1
                                ? StepState.complete
                                : StepState.indexed,
                            content: _buildPaymentForm(),
                          ),
                          Step(
                            title: const Text('Review Order'),
                            isActive: _currentStep >= 2,
                            state: StepState.indexed,
                            content: _buildOrderReview(),
                          ),
                        ],
                      ),
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

  void _nextStep() {
    if (_currentStep == 0 && !_formKey.currentState!.validate()) return;

    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _placeOrder(context);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Widget _buildShippingForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildField('Full Name'),
          const SizedBox(height: 16),
          _buildField('Address'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildField('City')),
              const SizedBox(width: 16),
              Expanded(child: _buildField('Postal Code')),
            ],
          ),
          const SizedBox(height: 16),
          _buildField('Phone Number', keyboard: TextInputType.phone),
        ],
      ),
    );
  }

  Widget _buildField(String label, {TextInputType keyboard = TextInputType.text}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboard,
      validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
    );
  }

  Widget _buildPaymentForm() {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          RadioListTile(
            title: const Text('Credit / Debit Card'),
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

  Widget _buildOrderReview() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Items',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            _summaryRow(
              'Shipping',
              shipping == 0 ? 'Free' : '\$${shipping.toStringAsFixed(2)}',
              valueColor: shipping == 0 ? AppColors.success : null,
            ),
            const Divider(height: 24),
            _summaryRow('Total', '\$${total.toStringAsFixed(2)}', isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {bool isTotal = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            )),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? (isTotal ? AppColors.primary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }

  void _placeOrder(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('✅ Order Placed Successfully!'),
        content: const Text(
          'Thank you for your order.\nYou will receive a confirmation email shortly.',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
