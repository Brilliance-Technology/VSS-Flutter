import 'package:flutter/material.dart';
import 'package:inventory_management/meta/screens/user_profile_screen/utils/custom_clipper.dart';

import 'top_bar.dart';

class StackContainer extends StatelessWidget {
  final String fullName;
  final String role;
  StackContainer({
    this.fullName,
    this.role,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        children: <Widget>[
          // Container(),
          // ClipPath(
          //   clipper: MyCustomClipper(),
          //   child: Container(
          //     child: FadeInImage.assetNetwork(
          //       placeholder: "assets/images/blob.jpg",
          //       image:
          //           "https://d12oja0ew7x0i8.cloudfront.net/images/Article_Images/ImageForArticle_16788(1).jpg",
          //       fit: BoxFit.cover,
          //     ),
          //     height: 300.0,
          //     // decoration: BoxDecoration(
          //     //   image: DecorationImage(
          //     //     image: (
          //     //         "https://www.bing.com/images/blob?bcid=S.DJRCIEA8kCSlP3IEO0tO5btzik......8"),
          //     //     fit: BoxFit.cover,
          //     //   ),
          //     // ),
          //   ),
          // ),
         
          TopBar(),
        ],
      ),
    );
  }
}
