import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigate(BuildContext context, Widget screen, {bool isPreview = false}) {
  Navigator.push(
      context,
      isPreview
          ? PageRouteBuilder(
              pageBuilder: (context, animation, anotherAnimation) {
                return screen;
              },
              transitionDuration: const Duration(milliseconds: 800),
              transitionsBuilder:
                  (context, animation, anotherAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            )
          : MaterialPageRoute(builder: (_) => screen));
}

navigateAndRemoveAll(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => screen),
    (Route<dynamic> route) => false,
  );
}
