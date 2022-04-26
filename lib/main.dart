import 'package:flower_shop/constants/constants.dart';
import 'package:flower_shop/providers/cart_provider.dart';
import 'package:flower_shop/providers/category_provider.dart';
import 'package:flower_shop/providers/order_provider.dart';
import 'package:flower_shop/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import '/providers/login_provider.dart';
import '/providers/register_provider.dart';
import '/screens/splash_screen.dart';
import '/theme/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: khaltiPublicKey,
      builder: (
        context,
        navigatorKey,
      ) =>
          ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => RegisterProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => LoginProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => ProductsProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CategoryProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => OrderProvider(),
            ),
          ],
          child: MaterialApp(
            title: 'Little Garden',
            theme: lightTheme(context),
            navigatorKey: navigatorKey,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
          ),
        ),
      ),
    );
  }
}
