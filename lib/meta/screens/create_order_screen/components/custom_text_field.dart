import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.textController,
      this.labelText,
      this.isphoneInput,
      this.validator,
      this.textInputType,
      this.padding,
      this.onChange,
      this.leading,
      this.value});
  final TextEditingController textController;
  final String labelText;
  final Function validator;
  final Function onChange;
  final bool isphoneInput;

  final TextInputType textInputType;
  final double padding;
  final String value;
  final Widget leading;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      alignment: Alignment.center,
      // padding: EdgeInsets.only(right: 10),
      height: 50,
      //  Get.size.width,
      child: Card(
          elevation: 11,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          child: TextFormField(
            initialValue: value,
            onChanged: onChange,
            validator: validator,
            controller: textController,
            keyboardType: textInputType,
            maxLength: isphoneInput == true ? 10 : 50,
            textInputAction: TextInputAction.done,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              prefix: leading,
              counterText: "",
              // prefix: prefix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(23),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.white,
              filled: true,
              labelText: labelText,

              //  labelText: label,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: BorderSide(
                    color: kPrimaryColorDark,
                  )),
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: etHintColor,
              ),
              // contentPadding: const EdgeInsets.symmetric(
              //   horizontal: 16,
              //   vertical: 100,
              // ),
            ),
          )),
    );
  }
}
