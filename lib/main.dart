import '/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/providers/login_provider.dart';
import '/providers/register_provider.dart';
import 'package:provider/provider.dart';
import '/screens/login_screen.dart';
import '/theme/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
        ],
        child: MaterialApp(
          title: 'E-Medic',
          theme: lightTheme(context),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
