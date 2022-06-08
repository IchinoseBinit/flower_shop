import 'package:flower_shop/providers/category_provider.dart';
import 'package:flower_shop/providers/login_provider.dart';
import 'package:flower_shop/providers/product_provider.dart';
import 'package:flower_shop/screens/cart_screen.dart';
import 'package:flower_shop/screens/change_password_screen.dart';
import 'package:flower_shop/screens/order_screen.dart';
import 'package:flower_shop/screens/popular_products.dart';
import 'package:flower_shop/screens/search_list/search_screen.dart';
import 'package:flower_shop/widgets/caregory_card.dart';
import 'package:flower_shop/widgets/general_alert_dialog.dart';
import 'package:flower_shop/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/utils/navigate.dart';
import '/widgets/curved_body_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoginProvider>(context, listen: false).user;
    final categoryFuture =
        Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    final latestProductsFuture =
        Provider.of<ProductsProvider>(context, listen: false)
            .fetchLatestProducts();

    final productsFuture =
        Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Home!"),
        actions: [
          IconButton(
            onPressed: () {
              navigate(context, const SearchScreen());
            },
            icon: const Icon(
              Icons.search_outlined,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(data?.user.username ?? "No Name"),
              accountEmail: Text(
                data?.user.email ?? "No Email",
              ),
            ),
            buildListTile(
              context,
              label: "Popular Products",
              widget: const PopularProducts(),
            ),
            SizedBox(
              height: 8.h,
            ),
            buildListTile(
              context,
              label: "My Cart",
              widget: const CartScreen(),
            ),
            SizedBox(
              height: 8.h,
            ),
            buildListTile(
              context,
              label: "My Orders",
              widget: const OrderScreen(),
            ),
            SizedBox(
              height: 8.h,
            ),
            buildListTile(
              context,
              label: "Change Password",
              widget: ChangePasswordScreen(),
            ),
            SizedBox(
              height: 8.h,
            ),
            const Spacer(),
            buildListTile(
              context,
              label: "Log Out",
              func: () async {
                try {
                  Provider.of<LoginProvider>(context, listen: false)
                      .logout(context);
                } catch (ex) {
                  GeneralAlertDialog()
                      .customAlertDialog(context, ex.toString());
                }
              },
            ),
          ],
        ),
      ),
      body: CurvedBodyWidget(
          widget: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 150,
              child: FutureBuilder(
                future: categoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<CategoryProvider>(
                    builder: (context, value, child) =>
                        value.listOfcategories.isEmpty
                            ? const SizedBox.shrink()
                            : ListView.separated(
                                itemBuilder: (context, index) => CategoryCard(
                                  category: value.listOfcategories[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 20),
                                itemCount: value.listOfcategories.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                primary: false,
                              ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Latest Products",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 150,
              child: FutureBuilder(
                future: latestProductsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<ProductsProvider>(
                    builder: ((context, value, child) =>
                        value.listOfLatestProducts.isEmpty
                            ? const SizedBox.shrink()
                            : ListView.builder(
                                itemBuilder: (context, index) => ProductCard(
                                  product: value.listOfLatestProducts[index],
                                ),
                                itemCount: value.listOfLatestProducts.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                primary: false,
                              )),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Products",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Consumer<ProductsProvider>(
                  builder: ((context, value, child) =>
                      value.listOfProducts.isEmpty
                          ? const SizedBox.shrink()
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                product: value.listOfProducts[index],
                              ),
                              itemCount: value.listOfProducts.length,
                              shrinkWrap: true,
                              primary: false,
                            )),
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  Widget buildListTile(
    BuildContext context, {
    required String label,
    Widget? widget,
    Function? func,
  }) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_right_outlined,
      ),
      onTap: () {
        if (widget != null) {
          navigate(context, widget);
        } else {
          func!();
        }
      },
    );
  }
}
