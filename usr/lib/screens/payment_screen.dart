import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedCurrency = 'NGN';
  String _selectedMethod = 'Card';
  final _amount = 3000.0; // Mock amount

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Consultation Fee: ₦$_amount', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text('Select Currency:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedCurrency,
              items: const [
                DropdownMenuItem(value: 'NGN', child: Text('Nigerian Naira (NGN)')),
                DropdownMenuItem(value: 'USD', child: Text('US Dollar (USD)')),
                DropdownMenuItem(value: 'GHS', child: Text('Ghanaian Cedi (GHS)')),
                DropdownMenuItem(value: 'KES', child: Text('Kenyan Shilling (KES)')),
              ],
              onChanged: (value) => setState(() => _selectedCurrency = value!),
            ),
            const SizedBox(height: 16),
            const Text('Payment Method:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedMethod,
              items: const [
                DropdownMenuItem(value: 'Card', child: Text('Credit/Debit Card')),
                DropdownMenuItem(value: 'Mobile', child: Text('Mobile Money')),
                DropdownMenuItem(value: 'Bank', child: Text('Bank Transfer')),
              ],
              onChanged: (value) => setState(() => _selectedMethod = value!),
            ),
            const SizedBox(height: 24),
            // Mock payment form
            TextField(decoration: const InputDecoration(labelText: 'Card Number')),
            TextField(decoration: const InputDecoration(labelText: 'Expiry Date')),
            TextField(decoration: const InputDecoration(labelText: 'CVV')),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _processPayment,
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }

  void _processPayment() {
    // Mock payment processing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment successful!')),
    );
    context.go('/consultation');
  }
}
