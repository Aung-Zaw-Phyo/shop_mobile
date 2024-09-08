import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  static const String baseUrl = 'http://10.0.2.2:5000';
  static const int paginateItemsLimit = 8;
  static String stripePublishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  static String stripeSecretKey = dotenv.env['STRIPE_SECRET_KEY']!;
}
