import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/app/data/models/order_response.dart';
import 'package:inventory_management/meta/screens/home/home_screen.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';
import 'package:inventory_management/meta/widgets/show_custom_dialog.dart';
import 'package:inventory_management/provider/cart_provider.dart';
import 'package:inventory_management/provider/users_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EditOrderDetails extends StatefulWidget {
  final Re order;

  const EditOrderDetails({Key key, this.order}) : super(key: key);
  @override
  _EditOrderDetailsState createState() => _EditOrderDetailsState();
}

class _EditOrderDetailsState extends State<EditOrderDetails> {
  String selectedProductionIncharge;
  DateTime assignDate;
  DateTime completionDate;
  static String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  final TextEditingController _assignDateController =
      TextEditingController(text: formattedDate);

  final TextEditingController _completionDateController =
      TextEditingController(text: formattedDate);

  final TextEditingController _noteController = TextEditingController();

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  Future buildMaterialDatePicker(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
          ),
          child: child,
        );
      },
    );

    if (newDate == null) return;

    setState(() {
      assignDate = newDate;
      String formattedDeliveryDate =
          DateFormat('dd-MM-yyyy').format(assignDate);
      _assignDateController.value =
          TextEditingValue(text: formattedDeliveryDate);
    });
  }

  buildCupertinoDatePicker(BuildContext context) {
    final initialDate = DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked == null) return;
                setState(() {
                  assignDate = picked;
                  String formattedDeliveryDate =
                      DateFormat('dd-MM-yyyy').format(assignDate);
                  _assignDateController.value =
                      TextEditingValue(text: formattedDeliveryDate);
                });
              },
              initialDateTime: initialDate,
              minimumYear: DateTime.now().year,
              maximumYear: DateTime.now().year + 1,
            ),
          );
        });
  }

  _selectCompletionDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildCompletionMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCompletionCupertinoDatePicker(context);
    }
  }

  Future buildCompletionMaterialDatePicker(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
          ),
          child: child,
        );
      },
    );

    if (newDate == null) return;

    setState(() {
      completionDate = newDate;
      String formattedDeliveryDate =
          DateFormat('dd-MM-yyyy').format(completionDate);
      _completionDateController.value =
          TextEditingValue(text: formattedDeliveryDate);
    });
  }

  buildCompletionCupertinoDatePicker(BuildContext context) {
    final initialDate = DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked == null) return;
                setState(() {
                  completionDate = picked;
                  String formattedDeliveryDate =
                      DateFormat('dd-MM-yyyy').format(completionDate);
                  _completionDateController.value =
                      TextEditingValue(text: formattedDeliveryDate);
                });
              },
              initialDateTime: initialDate,
              minimumYear: DateTime.now().year,
              maximumYear: DateTime.now().year + 1,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Edit Order",
        leadingWidget: null,
      ),
      body: Consumer<UsersProvider>(builder: (context, model, child) {
        return model.isInChargeListLoaded == true
            ? SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Client Name',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              'Date',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              'Delivery Date',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              'Order ID',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            Text(
                                              'Address',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.order.clientName.toString(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              widget.order.deliveryDate.toString(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              '23 - 3 - 21',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              widget.order.orderId.toString(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "${widget.order.address.toString()}, ${widget.order.city.toString()}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: bgEditText,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Consumer<UsersProvider>(
                          builder: (context, model, child) {
                        var inchargeList = model.usersList;
                        print("Incharge" + inchargeList.length.toString());
                        return DropdownButton(
                          isExpanded: true,
                          hint: Text("Production Incharge"),
                          elevation: 0,
                          underline: Text(""),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Monteserat",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          // iconSize: 0,
                          // icon: Icon(null),
                          value: selectedProductionIncharge,
                          dropdownColor: Colors.grey.shade300,
                          onChanged: (newValue) {
                            setState(() {
                              selectedProductionIncharge = newValue;
                            });
                          },
                          items: model.isLoading
                              ? []
                              : inchargeList.map((item) {
                                  var name =
                                      "${item.firstName} ${item.lastName}";
                                  return DropdownMenuItem(
                                    value: name,
                                    child: Text(name),
                                  );
                                }).toList(),
                        );
                      }),
                    ),
                    InputFieldWidget(
                      lable: "Assign Date",
                      deliveryDateController: _assignDateController,
                      onTap: () async {
                        await _selectDate(context);
                      },
                    ),
                    InputFieldWidget(
                      lable: "Completion Date",
                      deliveryDateController: _completionDateController,
                      onTap: () async {
                        await _selectCompletionDate(context);
                      },
                    ),
                    vSizedBox1,
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: textFieldNote()),
                    vSizedBox3,
                    Consumer<CartProvider>(
                      builder: (context, model, child) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          await model
                              .editProductionHeadDetails(
                            id: widget.order.id,
                            productionIncharge: selectedProductionIncharge,
                            assignDate: _assignDateController.text,
                            completionDate: _completionDateController.text,
                            context: context,
                            phNote: _noteController.text,
                          )
                              .whenComplete(() {
                            // showFlash(
                            //     context: context,
                            //     duration: Duration(seconds: 2),
                            //     builder: (context, controller) {
                            //       return Flash.dialog(
                            //         controller: controller,
                            //         borderRadius:
                            //             const BorderRadius.all(Radius.circular(8)),
                            //         backgroundColor: Colors.blue,
                            //         alignment: Alignment.bottomCenter,
                            //         margin: const EdgeInsets.only(bottom: 120),
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Text(
                            //             'Order Submitted',
                            //             style: const TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     });
                            showCustomDialog(context, "Success",
                                "Order sent to Production Incharge", () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                  // duration: Duration(milliseconds: 500),
                                  child: HomeScreen(),
                                  type: PageTransitionType.leftToRight,
                                ),
                                (r) => false,
                              );
                            });
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            hSizedBox1,
                            model.isLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(child: Center(child: CircularProgressIndicator()));
      }),
    );
  }

  Widget textFieldNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: _noteController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: bgEditText,
              filled: true,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: etHintColor,
              ),
              labelText: "Note",
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  )),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              // hintText: 'Firm Name',
            ),
          ),
        ),
      ],
    );
  }
}

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    Key key,
    @required TextEditingController deliveryDateController,
    @required Function onTap,
    @required String lable,
  })  : _deliveryDateController = deliveryDateController,
        _onTap = onTap,
        _lable = lable,
        super(key: key);

  final TextEditingController _deliveryDateController;
  final Function _onTap;
  final String _lable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _deliveryDateController,
              keyboardType: TextInputType.datetime,
              onTap: () {
                _onTap();
              },
              readOnly: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                fillColor: bgEditText,
                filled: true,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: etHintColor,
                ),
                labelText: _lable,
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    )),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                // hintText: 'Firm Name',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
