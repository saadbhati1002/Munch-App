import 'package:app/screen/splash/splash_screen.dart';
import 'package:app/utility/color.dart';
import 'package:app/utility/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // set the publishable key for Stripe - this is mandatory
  Stripe.publishableKey = AppConstant.stripePublic;
  Stripe.merchantIdentifier = 'Munch Mondays';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: ThemeData(
        fontFamily: "rubik",
        colorScheme:
            ColorScheme.fromSeed(seedColor: ColorConstant.backGroundColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
