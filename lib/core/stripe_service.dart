import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();

  static final StripeService instatnce = StripeService._();

  Future<String> makePayment(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "My Shop",
          style: ThemeMode.light,
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      final sessionId = clientSecret.split('_secret_')[0];
      return sessionId;
    } catch (e) {
      throw Exception('User has been canceled.');
    }
  }
}
