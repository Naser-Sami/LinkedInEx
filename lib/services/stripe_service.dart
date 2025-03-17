import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static final Dio dio = Dio();
  static final String _secretKey = dotenv.env['STRIPE_SECRET'].toString();
  static const String _baseUrl = 'https://api.stripe.com/v1';
  static final String _publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'].toString();

  // Initialize Stripe
  static void init() {
    Stripe.publishableKey = _publishableKey;
  }

  // Create a Payment Intent
  static Future<Map<String, dynamic>?> createPaymentIntent({
    required double amount,
    required String currency,
  }) async {
    try {
      int amountInCents = (amount * 100).toInt(); // Convert to smallest currency unit

      final headers = {
        'Authorization': 'Bearer $_secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      Map<String, dynamic> body = {
        'amount': amountInCents.toString(),
        'currency': currency,
        // check how to implement the payment method types
        'payment_method_types[]': 'card',
      };

      final response = await dio.post(
        "$_baseUrl/payment_intents",
        options: Options(method: 'POST', headers: headers),
        data: body,
      );

      return response.data;
    } catch (e) {
      throw Exception('Error creating payment intent: $e');
    }
  }

  // Process Payment
  static Future<void> processPayment({
    required double amount,
    required String currency,
  }) async {
    try {
      final paymentIntent = await createPaymentIntent(amount: amount, currency: currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          merchantDisplayName: 'LinkedInEX',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception('Payment failed:---> $e');
    }
  }
}
