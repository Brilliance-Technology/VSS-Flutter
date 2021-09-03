import 'package:flutter/material.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';

class StockHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Stock Manager",
        leadingWidget: null,
      ),
      body: Center(
        child: Text(
          "Stock here",
        ),
      ),
    );
  }
}
