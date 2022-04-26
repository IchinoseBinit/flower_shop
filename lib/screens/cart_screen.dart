import 'package:flower_shop/providers/cart_provider.dart';
import 'package:flower_shop/widgets/cart_card.dart';
import 'package:flower_shop/widgets/curved_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: CurvedBodyWidget(
          widget: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<CartProvider>(builder: (context, value, child) {
              return value.cart.isEmpty
                  ? const Center(
                      child: Text("No products added in cart"),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) => CartCard(
                        product: value.cart[index],
                      ),
                      itemCount: value.cart.length,
                      shrinkWrap: true,
                      primary: false,
                    );
            })
          ],
        ),
      )),
    );
  }
}
