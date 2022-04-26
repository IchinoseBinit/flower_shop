import 'dart:developer';

import 'package:flower_shop/models/order.dart';
import 'package:flower_shop/screens/home_screen.dart';
import 'package:flower_shop/utils/navigate.dart';
import 'package:flower_shop/widgets/curved_body_widget.dart';
import 'package:flower_shop/widgets/general_alert_dialog.dart';
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
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    Key? key,
    required this.productName,
    required this.price,
    required this.order,
  }) : super(key: key);
  final int price;
  final String productName;
  final Order order;

  makeConfig() {
    return PaymentConfig(
      amount: price * 100, // Amount should be in paisa
      productIdentity: order.product.toString(),
      productName: productName,
      productUrl: 'https://www.khalti.com/#/bazaar',
      additionalData: {
        // Not mandatory; can be used for reporting purpose
        'vendor': 'Little Garden',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = makeConfig();
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: KhaltiButton(
                  config: config,
                  preferences: const [
                    PaymentPreference.khalti,
                  ],
                  onSuccess: (successModel) async {
                    GeneralAlertDialog().customLoadingDialog(context);
                    // await Provider.of<TicketProvider>(context, listen: false)
                    //     .bookTicket(
                    //         code: successModel.idx,
                    //         ticketId: tempTicket.id,
                    //         seatId: seatId);
                    await Future.delayed(const Duration(seconds: 3));
                    Navigator.pop(context);
                    await GeneralAlertDialog()
                        .customAlertDialog(context, "Successfully booked");

                    // // Perform Server Verification
                    navigateAndRemoveAll(context, const HomeScreen());
                  },
                  onFailure: (failureModel) {
                    // What to do on failure?
                    // log(failureModel.data.toString());
                    GeneralAlertDialog()
                        .customAlertDialog(context, failureModel.message);
                  },
                  onCancel: () {
                    // User manually cancelled the transaction
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
