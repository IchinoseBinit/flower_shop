import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralTableRow {
  TableRow buildTableSpacer(BuildContext context) {
    return TableRow(children: [
      SizedBox(
        height: 8.h,
      ),
      SizedBox(
        height: 8.h,
      ),
    ]);
  }

  TableRow buildTableDivider(BuildContext context) {
    return const TableRow(children: [
      Divider(
        thickness: 1,
      ),
      Divider(
        thickness: 1,
      ),
    ]);
  }

  TableRow buildTableRow(
    BuildContext context, {
    required String title,
    double? amount,
    String? month,
    bool isAmount = true,
  }) {
    return TableRow(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 14.sp,
              ),
        ),
        Text(
          isAmount ? "Rs. $amount" : month!,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14.sp,
              ),
        ),
      ],
    );
  }
}
