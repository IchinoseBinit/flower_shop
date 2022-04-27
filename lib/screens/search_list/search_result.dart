import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '/providers/product_provider.dart';
import '/screens/search_list/search_field.dart';
import '/screens/search_list/search_screen.dart';
import '/widgets/product_card.dart';

class SearchResultScreen extends StatefulWidget {
  static const routeName = "/searchResult";
  const SearchResultScreen(this.searchValue, {Key? key}) : super(key: key);

  final String searchValue;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  RangeValues values = const RangeValues(1, 100);
  RangeLabels labels = const RangeLabels("1", "100");

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductsProvider>(context, listen: false)
        .searchProducts(widget.searchValue);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => SearchScreen(
              autoFocus: true,
              value: widget.searchValue,
            ),
          ),
        );
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 8.h,
                ),
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
                        // radius: 15.r * 3,
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => SearchScreen(
                                  autoFocus: true,
                                  value: widget.searchValue,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: SearchField(
                          value: widget.searchValue,
                          autoFocus: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                getSearchProducts(
                  context,
                  widget.searchValue,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchProducts(BuildContext context, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
          ),
          child: Text(
            "Search results for $name",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Consumer<ProductsProvider>(builder: (_, data, __) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.h,
            ),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: data.searchedProducts.length,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: data.searchedProducts[index],
              );
            },
          );
        }),
      ],
    );
  }
}
