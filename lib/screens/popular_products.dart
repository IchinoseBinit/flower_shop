import 'package:flower_shop/providers/product_provider.dart';
import 'package:flower_shop/widgets/curved_body_widget.dart';
import 'package:flower_shop/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final popularProductsFuture =
        Provider.of<ProductsProvider>(context, listen: false)
            .fetchPopularProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Products"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: popularProductsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<ProductsProvider>(
                    builder: (context, value, child) =>
                        value.listOfPopularProducts.isEmpty
                            ? const Center(
                                child: Text("No Popular Products currently"),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (context, index) => ProductCard(
                                  product: value.listOfPopularProducts[index],
                                ),
                                itemCount: value.listOfPopularProducts.length,
                                shrinkWrap: true,
                                primary: false,
                              ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
