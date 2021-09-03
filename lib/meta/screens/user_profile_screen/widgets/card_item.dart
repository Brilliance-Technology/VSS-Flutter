import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inventory_management/app/constants/colors.dart';

class CardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const CardItem({
    Key key,
    this.icon,
    this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: Get.size.width / 6,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            //  size: 32.0,
            color: kPrimaryColorDark,
          ),
        ),
        Text(
          ":",
          style:
              TextStyle(color: kPrimaryColorDark, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: Get.size.width / 20),
        Text(
          value,
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
        Spacer()
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     // Text(
        //     //   label,
        //     //   style: TextStyle(
        //     //     fontSize: 18.0,
        //     //     fontWeight: FontWeight.bold,
        //     //   ),
        //     // ),
        //     SizedBox(height: 4.0),

        //     //),
        //   ],
        // ),
      ],
    );
  }
}
