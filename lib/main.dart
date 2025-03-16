import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'services/stripe_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/.env");

  StripeService.init();
  Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stripe Payment Example',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        appBar: AppBar(title: const Text('Stripe Payment Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => makePayment(),
            child: const Text('Make Payment'),
          ),
        ),
      ),
    );
  }

  void makePayment() async {
    try {
      final total = 19.99;

      await StripeService.processPayment(amount: total, currency: 'usd');
    } catch (e) {
      debugPrint('message: Error processing payment: $e');
    }
  }
}
