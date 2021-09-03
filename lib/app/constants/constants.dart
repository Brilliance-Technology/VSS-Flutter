import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  Constants._();
  static const labelTextStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 24);
  static const valueTextStyle = const TextStyle(
      color: Colors.black54, fontWeight: FontWeight.w300, fontSize: 24);
  static const String user_key = "current_user";
  static const String authToken = "tokens";

  // Lists for dropdown menu of products
  static const List<String> companies = [
    "NA",
    "NSAIL",
    "JSW",
    "UTTAM",
    "AMNS",
    "ESSAR",
    "SAIL",
    "TATA",
    "ASIAN",
    "inventory"
  ];

  static const List<String> grades = [
    "NA",
    "PRIME",
    "SECOND",
    "DEFECTIVE",
    "test"
  ];

  static const List<String> topColors = [
    "NA",
    "REG",
    "SP",
    "TL",
    "BLUE",
    "WHITE",
    "SECO RED",
    "BRICK RED",
    "YELLOW",
    "DARK GREY",
    "LIGHT GREY",
    "ENVIR GREEN",
    "MIST GREEN",
    "ROYAL BLUE",
    "red",
    "ORANGE"
  ];

  static const List<String> coatings = [
    "null",
    "70",
    "80",
    "90",
    "120",
    "150",
    "180",
    "275"
  ];

  static const List<String> tempers = [
    "NA",
    "FullHard",
    "SemiHard",
    "Soft",
    "ExtraSoft",
    "DD",
    "EDD",
    "2062",
    "xyz",
    "1079"
  ];

  static const List<String> guardFilms = [
    "NA",
    "Without",
    "Skyline",
    "Hindustan",
    "Asian",
    "Rangoli",
    "xyz"
  ];
}
