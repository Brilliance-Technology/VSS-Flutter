import 'package:flutter/material.dart';
import 'package:inventory_management/app/constants/colors.dart';

class ReadyMadeTextTile extends StatelessWidget {
  const ReadyMadeTextTile({Key key, @required this.label, @required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: size.width * 0.024,
                color: Colors.black.withOpacity(0.5)),
          ),
          SizedBox(
            width: size.width / 30,
          ),
          Card(
            elevation: 11,
            shadowColor: Colors.grey.withOpacity(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 0, horizontal: size.width / 20),
              height: 24,
              //width: size.width / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Center(
                child: Text(value,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size.width * 0.026,
                      color: kPrimaryColorTextDark,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
