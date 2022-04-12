import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigate(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

navigateUntil(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (_) => screen), (_) => false);
}
