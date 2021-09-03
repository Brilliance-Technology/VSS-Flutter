import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDropDownChild extends StatelessWidget {
  final String content;
  final String startDate;
  final String endDate;
  CustomDropDownChild({this.content, this.startDate, this.endDate});
  final formater = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      // height: size.height,

      child: Row(
        children: [
          Text(content),
          Spacer(),
          Text(
            startDate,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(
            width: size.width / 30,
          ),
          Text("-",
              style: TextStyle(
                  fontSize: 14, color: Colors.black.withOpacity(0.5))),
          SizedBox(
            width: size.width / 30,
          ),
          Text(
            endDate,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}
