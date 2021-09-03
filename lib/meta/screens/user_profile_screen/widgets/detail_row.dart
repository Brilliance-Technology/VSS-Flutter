import 'package:flutter/material.dart';
import 'package:inventory_management/app/constants/constants.dart';

Padding buildDetailRow({@required String title, @required String data}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: Constants.labelTextStyle.copyWith(fontSize: 17),
          ),
        ),
        // Spacer(),

        // hSizedBox2,
        // Spacer(),
        Expanded(
          child: Text(
            data.toString(),
            style: TextStyle(fontSize: 17, color: Colors.black54),
          ),
        ),
      ],
    ),
  );
}
