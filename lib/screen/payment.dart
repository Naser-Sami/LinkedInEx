import 'package:flutter/material.dart';
import '/services/stripe_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stripe Payment Example')),
      body: Center(
        child: TextButton(
          onPressed: () => makePayment(),
          child: const Text(
            'Make Payment',
            style: TextStyle(decoration: TextDecoration.underline, fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  void makePayment() async {
    try {
      final total = 19.99;
      await StripeService.processPayment(amount: total, currency: 'usd');

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Payment Successful')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment failed. Please try again.')),
        );
      }
    }
  }
}
