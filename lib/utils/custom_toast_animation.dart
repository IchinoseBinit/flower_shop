import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimatedToast extends StatefulWidget {
  const CustomAnimatedToast({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => CustomAnimatedToastState();
}

class CustomAnimatedToastState extends State<CustomAnimatedToast>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..forward(from: 0);

    offset = Tween<Offset>(
      // begin: Offset(0.0, 1.0),
      //change first offset value to change left right position
      begin: Offset(0.3, 1.0),
      // end: Offset(0.0, 0.0),
      end: Offset(0.3, 0.0),
    ).animate(controller);

    Future<void>.delayed(Duration(milliseconds: 1800), () {
      controller.reverse();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          SlideTransition(
            position: offset,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 250,
                  child: Center(
                      child: Image.asset(
                    "assets/images/boquet.png",
                    height: 80.h,
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
