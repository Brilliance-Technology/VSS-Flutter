import 'package:flutter/material.dart';

void showCustomDialog(
    BuildContext ctx, String title, String description, Function onPressed) {
  showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Text(
            description,
            textAlign: TextAlign.center,
          )),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onPressed: () => onPressed(),
        )
      ],
    ),
  );
}
