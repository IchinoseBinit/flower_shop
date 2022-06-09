import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimatedToast extends StatefulWidget {
  const CustomAnimatedToast({
    Key? key,
    required this.productImage,
  }) : super(key: key);

  final String productImage;
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

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..forward(from: 0);

    offset = Tween<Offset>(
      // begin: Offset(0.0, 1.0),
      //change first offset value to change left right position
      begin: const Offset(0.3, 1),
      // end: Offset(0.0, 0.0),
      end: const Offset(0.3, 0.0),
    ).animate(controller);

    // Future<void>.delayed(const Duration(milliseconds: 1800), () {
    //   controller.reverse();
    // });
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
                    vertical: 10.h,
                    horizontal: 10.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    // color: Colors.black,
                  ),
                  width: 250,
                  height: 350,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.productImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
