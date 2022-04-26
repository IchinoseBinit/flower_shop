import 'package:flower_shop/models/category.dart';
import 'package:flower_shop/providers/product_provider.dart';
import 'package:flower_shop/widgets/curved_body_widget.dart';
import 'package:flower_shop/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsByCategoriesScreen extends StatelessWidget {
  const ProductsByCategoriesScreen({Key? key, required this.category})
      : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<ProductsProvider>(context, listen: false)
        .fetchProductsByCategory(category.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(category.categoryName),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: FutureBuilder(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Consumer<ProductsProvider>(
                      builder: (context, value, child) => value
                              .listOfProductsByCategory.isEmpty
                          ? Center(
                              child: Text(
                                  "No Products in the ${category.categoryName} category currently"),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                product: value.listOfProductsByCategory[index],
                              ),
                              itemCount: value.listOfProductsByCategory.length,
                              shrinkWrap: true,
                              primary: false,
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
