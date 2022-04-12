import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/utils/navigate.dart';
import '/widgets/curved_body_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = null;
    // final future =
    //     Provider.of<RoomProvider>(context, listen: false).fetchRoom(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Home!"),
        actions: [
          IconButton(
            onPressed: () async {
              // final roomName =
              //     await GeneralBottomSheet().customBottomSheet(context);
              // // print(roomName);
              // if (roomName != null) {
              //   try {
              //     GeneralAlertDialog().customLoadingDialog(context);
              //     await Provider.of<RoomProvider>(context, listen: false)
              //         .addRoom(context, roomName);
              //     Navigator.pop(context);
              //     Navigator.pop(context);
              //   } catch (ex) {
              //     Navigator.pop(context);
              //     GeneralAlertDialog()
              //         .customAlertDialog(context, ex.toString());
              //   }
              // }
            },
            icon: const Icon(
              Icons.add_outlined,
            ),
          )
        ],
      ),
      drawer: Drawer(
          child: Column(
        children: [
          // Consumer<UserProvider>(builder: (_, data, __) {
          //   // data.
          //   return
          UserAccountsDrawerHeader(
            accountName: Text(data?.user?.name ?? "No Name"),
            accountEmail: Text(
              data?.user?.email ?? "No Email",
            ),
            currentAccountPicture: Hero(
              tag: "image-url",
              child: SizedBox(
                height: 128.h,
                width: 128.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(64.r),
                  child: data?.user?.image == null
                      ? Image.network(
                          "image",
                          fit: BoxFit.cover,
                        )
                      : Image.memory(
                          base64Decode(data.user.image!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
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
          children: [],
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
