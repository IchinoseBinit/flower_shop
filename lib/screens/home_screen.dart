import 'package:flower_shop/providers/category_provider.dart';
import 'package:flower_shop/providers/login_provider.dart';
import 'package:flower_shop/providers/product_provider.dart';
import 'package:flower_shop/widgets/caregory_card.dart';
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

    final productsFuture = Provider.of<ProductsProvider>(context, listen: false)
        .fetchLatestProducts();
    // final future =
    //     Provider.of<RoomProvider>(context, listen: false).fetchRoom(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Home!"),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          // Consumer<UserProvider>(builder: (_, data, __) {
          //   // data.
          //   return
          UserAccountsDrawerHeader(
            accountName: Text(data?.user.username ?? "No Name"),
            accountEmail: Text(
              data?.user.email ?? "No Email",
            ),
          ),

          // buildListTile(
          //   context,
          //   label: "List of Medicines",
          //   widget: ListOfMedicines(
          //     title: "List of Medicines",
          //   ),
          // ),
          // SizedBox(
          //   height: 8.h,
          // ),
          // buildListTile(
          //   context,
          //   label: "Surgical Items",
          //   widget: SurgicalItems(
          //     title: "Surgical Items",
          //   ),
          // ),
          SizedBox(
            height: 8.h,
          ),
        ],
      )),
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
                            : ListView.builder(
                                itemBuilder: (context, index) => CategoryCard(
                                  category: value.listOfcategories[index],
                                ),
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
                      value.listOfLatestProducts.isEmpty
                          ? const SizedBox.shrink()
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                product: value.listOfLatestProducts[index],
                              ),
                              itemCount: value.listOfLatestProducts.length,
                              shrinkWrap: true,
                              primary: false,
                            )),
                );
              },
            ),
          ],
        ),
      )
          // FutureBuilder(
          //     future: future,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //       final listOfRoom = Provider.of<RoomProvider>(
          //         context,
          //       ).listOfRoom;
          //       return listOfRoom.isEmpty
          //           ? const Center(
          //               child: Text("You do not have any rooms!"),
          //             )
          //           : SingleChildScrollView(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Your Rooms",
          //                     style: Theme.of(context).textTheme.headline6,
          //                   ),
          //                   SizedBox(
          //                     height: SizeConfig.height,
          //                   ),
          //                   GridView.builder(
          //                     itemCount: listOfRoom.length,
          //                     gridDelegate:
          //                         SliverGridDelegateWithFixedCrossAxisCount(
          //                       crossAxisCount: 3,
          //                       childAspectRatio: 2,
          //                       mainAxisSpacing: SizeConfig.height,
          //                       crossAxisSpacing: SizeConfig.width * 4,
          //                     ),
          //                     itemBuilder: (context, index) {
          //                       return InkWell(
          //                         onTap: () => navigate(context,
          //                             RoomScreen(room: listOfRoom[index])),
          //                         child: Card(
          //                           color: Colors.red.shade200,
          //                           child: Center(
          //                             child: Text(
          //                               listOfRoom[index].name,
          //                             ),
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                     shrinkWrap: true,
          //                   )
          //                 ],
          //               ),
          //             );
          //     }),

          ),
    );
  }

  Widget buildListTile(
    BuildContext context, {
    required String label,
    required Widget widget,
  }) {
    return ListTile(
      title: Text(label),
      trailing: const Icon(
        Icons.arrow_right_outlined,
      ),
      onTap: () => navigate(context, widget),
    );
  }
}
