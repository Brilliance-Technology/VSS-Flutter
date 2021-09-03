import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/app/constants/colors.dart';

Widget appBar(
    {@required String title,
    @required Widget leadingWidget,
    List<Widget> actions}) {
  return AppBar(
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    backgroundColor: kPrimaryColorDark,
    elevation: 0,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(
    //     bottom: Radius.circular(30),
    //   ),
    // ),
    centerTitle: true,

    title: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    leading: leadingWidget,
    actions: actions,
  );
}
