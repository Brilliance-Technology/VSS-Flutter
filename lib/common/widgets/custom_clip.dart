import 'package:flutter/cupertino.dart';

class CustomClipHeader extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    var path = new Path();
    path.lineTo(0, size.height / 5);
    var firstControlPoint = new Offset(size.width / 4, size.height / 3.9);
    var firstEndPoint = new Offset(size.width / 1.7, size.height / 4.8);
    var secondControlPoint =
        new Offset(size.width - (size.width / 7.7), size.height / 5.3);
    var secondEndPoint = new Offset(size.width, size.height / 2.8 - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
 
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {


    return false;

  }
}
