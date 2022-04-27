import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/screens/search_list/search_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({this.autoFocus = true, this.value, Key? key})
      : super(key: key);

  final bool autoFocus;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 16.h,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor:
                          Theme.of(context).textTheme.headline6!.color,
                      // radius: SizeConfig.imageSizeMultiplier * 3,
                      child: IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: SearchField(
                        value: value ?? "",
                        autoFocus: autoFocus,
                        isSearchScreen: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
