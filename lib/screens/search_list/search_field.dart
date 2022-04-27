import 'dart:developer';

import 'package:flower_shop/screens/product_details_screen.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/screens/search_list/search_screen.dart';

import '/screens/search_list/search_result.dart';

// import '/constant/color_properties.dart';
import '/models/product.dart';
import '/providers/product_provider.dart';
// import '/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    this.value,
    this.autoFocus = true,
    this.isSearchScreen = true,
    Key? key,
  }) : super(key: key);

  final String? value;
  final bool autoFocus;
  final bool isSearchScreen;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Product>(
      optionsViewBuilder: (context, function, products) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              width: double.infinity,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: products.length,
                  separatorBuilder: (c, i) {
                    return Divider(
                      height: 1,
                      color: Colors.grey,
                      endIndent: 100.w,
                    );
                  },
                  itemBuilder: (c, i) {
                    return ListTile(
                      onTap: () => navigate(context,
                          ProductDetailsScreen(product: products.toList()[i])),
                      title: Text(products.toList()[i].productName),
                    );
                  }),
            ));
      },
      fieldViewBuilder: (context, controller, focusNode, function) {
        controller.text = value ?? "";
        return TextFormField(
            controller: controller,
            autofocus: autoFocus,
            focusNode: focusNode,
            onTap: () {
              log(value.toString());
              if (isSearchScreen) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => SearchScreen(
                      autoFocus: true,
                      value: controller.text,
                    ),
                  ),
                );
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 8.w,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  25.r,
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  25.r,
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  25.r,
                ),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              // isDense: true,
              hintText: "Search product",
            ),
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (newValue) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => SearchResultScreen(
                    newValue,
                  ),
                ),
              );
            });
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Product>.empty();
        }
        Provider.of<ProductsProvider>(context, listen: false)
            .searchProducts(textEditingValue.text.trim());

        return Provider.of<ProductsProvider>(context, listen: false)
            .searchedProducts;
      },
    );
  }
}
