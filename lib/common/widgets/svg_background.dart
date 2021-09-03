import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/widgets/custom_clip.dart';

class SvgBackground extends StatelessWidget {
  SvgBackground({this.content, this.headerContent});
  final Widget content;
  final Widget headerContent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              content,
              ClipPath(
                clipper: CustomClipHeader(),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/header.png"),
                            fit: BoxFit.fill)),
                    height: size.height / 1.5,
                    width: size.width,
                    child: headerContent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
