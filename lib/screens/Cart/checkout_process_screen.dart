import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_app/constants.dart';
import 'package:provider/provider.dart';

import '../../Provider/add_to_cart_provider.dart';

class CheckoutProcessScreen extends StatefulWidget {
  const CheckoutProcessScreen({super.key});

  @override
  State<CheckoutProcessScreen> createState() => _CheckoutProcessScreenState();
}

class _CheckoutProcessScreenState extends State<CheckoutProcessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  bool _payOnReceive = false;

  void _placeOrder() {
    if (_formKey.currentState!.validate()) {
      Provider.of<CartProvider>(context, listen: false).clearCart();

      // Display confirmation message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Order Placed'),
          content: Text(
            'Your order has been placed successfully!\nOn the way. Your order will arrive in 2-3 hours\nPayment Method: ${_payOnReceive ? "Pay on Receive" : "Online Payment"}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _secondNameController,
                decoration: const InputDecoration(
                  labelText: 'Second Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your second name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Delivery Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text('Pay on Receive'),
                value: _payOnReceive,
                onChanged: (value) {
                  setState(() {
                    _payOnReceive = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimaryColor,
                  minimumSize: const Size(double.infinity, 55),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}