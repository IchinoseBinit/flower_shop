import 'package:flower_shop/models/order.dart';
import 'package:flower_shop/screens/home_screen.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flower_shop/widgets/curved_body_widget.dart';
import 'package:flower_shop/widgets/one_details_displayer.dart';
import 'package:flutter/material.dart';
// import 'package:hamro_cinema/models/shows.dart';
// import 'package:hamro_cinema/models/temp_ticket.dart';
// import 'package:hamro_cinema/providers/seat_provider.dart';
// import 'package:hamro_cinema/providers/ticket_provider.dart';
// import 'package:hamro_cinema/screens/home_screen.dart';
// import 'package:hamro_cinema/utils/navigate.dart';
// import 'package:hamro_cinema/widgets/curved_body_widget.dart';
// import 'package:hamro_cinema/widgets/detail_displayer.dart';
// import 'package:hamro_cinema/widgets/general_alert_dialog.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    Key? key,
    required this.productName,
    required this.price,
    required this.order,
    this.isCashOnDelivery = true,
  }) : super(key: key);
  final int price;
  final String productName;
  final Order order;
  final bool isCashOnDelivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pay"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Bill Details",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OneDetailDisplayer(
                        title: "Product Name",
                        value: productName,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      OneDetailDisplayer(
                        title: "Quantity",
                        value: order.quantity.toString(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      OneDetailDisplayer(
                        title: "Price",
                        value: "Rs. $price",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      OneDetailDisplayer(
                        title: "Shipping Time",
                        value: DateFormat("yyyy MMM dd hh:mm a").format(
                          order.shippingTime,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      OneDetailDisplayer(
                        title: "Payment Type",
                        value: isCashOnDelivery ? "Cash on Delivery" : "Khalti",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                  child: ElevatedButton.icon(
                icon: const Icon(Icons.home_outlined),
                onPressed: () =>
                    navigateAndRemoveAll(context, const HomeScreen()),
                label: const Text("Go to Home"),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
