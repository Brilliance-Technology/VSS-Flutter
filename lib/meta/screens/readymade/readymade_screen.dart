import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/controllers/ready_made_orders_controller.dart';
import 'package:inventory_management/meta/screens/create_order_screen/create_ready_made_order_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'components/ready_made_product_tile.dart';

class ReadymadeScreen extends StatelessWidget {
  final ReadMadeOrderController _readMadeOrderController =
      Get.put(ReadMadeOrderController());

  onRefresh() => Future.delayed(Duration(seconds: 2), () {
        _readMadeOrderController.getAllReadyMadeOrders();
        //ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => _readMadeOrderController.isLoading.value == true
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Center(child: CircularProgressIndicator()))
            : Obx(
                () => _readMadeOrderController.readymadeOrdersList
                        .toList()
                        .isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Orders found",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    onRefresh();
                                  },
                                  child: Text(
                                    "Refresh",
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ],
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: RefreshIndicator(
                          child: Container(
                            padding: EdgeInsets.only(top: Get.size.height / 80),
                            child: Obx(
                              () => ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _readMadeOrderController
                                      .readymadeOrdersList.length,
                                  itemBuilder: (context, index) {
                                    return ReadyMadeProductTile(
                                      readyMade: _readMadeOrderController
                                          .readymadeOrdersList
                                          .toList()[index],
                                    );
                                  }),
                            ),
                          ),
                          onRefresh: () => onRefresh(),
                        ),
                      ),
              ),
      ),

      // floatingActionButton:
      //     _readMadeOrderController.isUserDispachInCharge.value == true
      //         ? FloatingActionButton(
      //             backgroundColor: Colors.grey.shade800,
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 PageTransition(
      //                   // duration: Duration(milliseconds: 500),
      //                   child: CreateReadyMadeOrderScreen(),
      //                   type: PageTransitionType.rightToLeft,
      //                 ),
      //               );
      //             },
      //             child: Icon(
      //               Icons.add,
      //               color: Colors.white,
      //             ),
      //           )
      //         : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    // return Consumer<OrderProvider>(builder: (context, model, child) {
    //   // var orders = model.ordersList;
    //   return Scaffold(
    //     body: Center(
    //       child: Text(
    //         "No Orders found",
    //         style: TextStyle(
    //           fontSize: 20,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ),
    // body: model.isLoading
    //     ? Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     : Container(
    //         child: model.readymadeOrdersList.isEmpty
    //             ? Center(
    //                 child: Text(
    //                   "No Orders found",
    //                   style: TextStyle(
    //                       fontSize: 24, fontWeight: FontWeight.bold),
    //                 ),
    //               )
    //             : ListView.builder(
    //                 itemCount: model.readymadeOrdersList.length,
    //                 itemBuilder: (context, index) {
    //                   return ProductTile(
    //                     order: model.readymadeOrdersList[index],
    //                   );
    //                 },
    //               ),
    // );
    // body: FutureBuilder<OrderResponse>(
    //     future: model.getAllOrders(context),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return ListView.builder(
    //             itemCount: snapshot.data.res.length,
    //             itemBuilder: (context, index) {
    //               return ProductTile(
    //                 order: snapshot.data.res[index],
    //               );
    //             });
    //       }
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }),
    // floatingActionButton: FloatingActionButton(
    //   backgroundColor: Colors.grey.shade800,
    //   onPressed: () {
    //     Navigator.push(
    //       context,
    //       PageTransition(
    //         // duration: Duration(milliseconds: 500),
    //         child: CreateOrderScreen(),
    //         type: PageTransitionType.rightToLeft,
    //       ),
    //     );
    //   },
    //   child: Icon(
    //     Icons.add,
    //     color: Colors.white,
    //   ),
    // ),
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  }
}
