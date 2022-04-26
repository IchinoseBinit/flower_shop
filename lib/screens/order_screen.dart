import 'package:flower_shop/providers/order_provider.dart';
import 'package:flower_shop/widgets/curved_body_widget.dart';
import 'package:flower_shop/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderFuture =
        Provider.of<OrderProvider>(context, listen: false).fetchOrders(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: orderFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<OrderProvider>(
                    builder: (context, value, child) =>
                        value.listOfOrders.isEmpty
                            ? const Center(
                                child: Text("No Popular Products currently"),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 16,
                                ),
                                itemBuilder: (context, index) => SizedBox(
                                  height: 120,
                                  child: OrderCard(
                                    order: value.listOfOrders[index],
                                    aspectRetio: 0.5,
                                  ),
                                ),
                                itemCount: value.listOfOrders.length,
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
