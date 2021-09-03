import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker {
  final bool isOnChangedUsed;
  bool isForFilter = false;
  CustomDatePicker(this.isOnChangedUsed, {this.isForFilter});
  selectDate(
      {BuildContext context,
      DateTime deliveryDate,
      TextEditingController dateController,
      String orderDate}) async {
    final ThemeData theme = Theme.of(context);

    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(
            context: context,
            deliveryDate: deliveryDate,
            dateController: dateController,
            orderDate: orderDate);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(
            context: context,
            deliveryDate: deliveryDate,
            dateController: dateController,
            orderDate: orderDate);
    }
  }

  buildCupertinoDatePicker(
      {BuildContext context,
      DateTime deliveryDate,
      TextEditingController dateController,
      String orderDate}) {
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

                deliveryDate = picked;
                String formattedDeliveryDate =
                    isForFilter==true?DateFormat('yyyy-MM-dd').format(deliveryDate): DateFormat('dd-MM-yyyy').format(deliveryDate);
                dateController.value =
                    TextEditingValue(text: formattedDeliveryDate);
              },
              initialDateTime:
                  isOnChangedUsed == true ? orderDate.toString() : initialDate,
              minimumYear: true ? DateTime.now().year - 1 : DateTime.now().year,
              maximumYear: DateTime.now().year + 1,
            ),
          );
        });
  }

  Future buildMaterialDatePicker(
      {BuildContext context,
      DateTime deliveryDate,
      TextEditingController dateController,
      String orderDate}) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: isOnChangedUsed == true
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(orderDate))
          : initialDate,
      firstDate: isForFilter
          ? DateTime.now().subtract(Duration(days: 365))
          : DateTime.now(),
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

    deliveryDate = newDate;

        String formattedDeliveryDate =isForFilter==true?DateFormat('yyyy-MM-dd').format(deliveryDate): DateFormat('dd-MM-yyyy').format(deliveryDate);

    if (isOnChangedUsed == true) {
    } else
      dateController.value = TextEditingValue(text: formattedDeliveryDate);
  }
}
