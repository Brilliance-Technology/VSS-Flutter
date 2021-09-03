import 'package:flutter/material.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/dimentions.dart';

class CalculateDialogSales extends StatefulWidget {
  @override
  _CalculateDialogSalesState createState() => _CalculateDialogSalesState();
}

class _CalculateDialogSalesState extends State<CalculateDialogSales> {
  var feetController = TextEditingController(text: "0.0");
  var inchesController = TextEditingController(text: "0.0");

  var finalValue = 0.0;
  var feetToInches = 0.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 10,
          right: 10,
          bottom: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    "Converter",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            vSizedBox1,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "FEET",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      vSizedBox1,
                      TextField(
                        controller: feetController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value != null) {
                            feetToInches = double.tryParse(value) * 12;
                            setState(() {
                              finalValue = feetToInches * 25.4;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: bgEditText,
                          filled: true,
                          // labelText: "FEET",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: etHintColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 0,
                          ),

                          // hintText: 'Client Name',
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "INCH",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      vSizedBox1,
                      TextField(
                        controller: inchesController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value != null) {
                            feetToInches =
                                feetToInches + double.tryParse(value);

                            print(feetToInches);
                            setState(() {
                              finalValue = feetToInches * 25.4;
                            });
                            print(finalValue);
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: bgEditText,
                          filled: true,
                          // labelText: "INCH",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: etHintColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 0,
                          ),

                          // hintText: 'Client Name',
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(
                      "=",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "MM",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      vSizedBox1,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: bgEditText,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "${finalValue.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              // alignment: Alignment.topRight,
              padding: const EdgeInsets.only(
                // right: 10,
                top: 20,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: productContainerColor,
                  onPrimary: Colors.grey.shade600,
                  onSurface: Colors.grey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, finalValue.toStringAsFixed(2));
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
