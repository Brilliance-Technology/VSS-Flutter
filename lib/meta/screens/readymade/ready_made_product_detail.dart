import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/constants.dart';

import 'package:inventory_management/app/data/models/ready_made_model.dart';
import 'package:inventory_management/common/widgets/svg_background.dart';
import 'package:inventory_management/meta/screens/readymade_order_submit/ready_made_order_submit_screen.dart';

// class ReadyMadeProductDetailScreen extends StatelessWidget {
//   final ReadyMade readyMadeProduct;
//   ReadyMadeProductDetailScreen({this.readyMadeProduct});
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SvgBackground(
//       content: Container(
//         child: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   child: FadeInImage.assetNetwork(
//                       placeholder: "assets/images/loading.gif",
//                       image:
//                           "https://d12oja0ew7x0i8.cloudfront.net/images/Article_Images/ImageForArticle_16788(1).jpg"),
//                 ),
//                 Container(
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                     width: size.width,
//                     color: Colors.grey[300],
//                     child: Column(
//                       children: [
//                         ProductTextTile(
//                             label: "Product",
//                             value: readyMadeProduct.selectProduct.toString()),
//                         ProductTextTile(
//                             label: "Company",
//                             value: readyMadeProduct.company.toString()),
//                         ProductTextTile(
//                             label: "Grade",
//                             value: readyMadeProduct.grade.toString()),
//                         Container(
//                             width: Get.width,
//                             child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: ProducTextHalfTitle(
//                                       devision: 1,
//                                       label: "Temper",
//                                       value: readyMadeProduct.temper.toString(),
//                                     ),
//                                   ),
//                                   ProducTextHalfTitle(
//                                     devision: 2.5,
//                                     label: "Coating",
//                                     value: readyMadeProduct.coating.toString(),
//                                   ),
//                                 ])),
//                         Container(
//                             width: Get.width,
//                             child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: ProducTextHalfTitle(
//                                       devision: 1,
//                                       label: "Top Color",
//                                       value:
//                                           readyMadeProduct.topcolor.toString(),
//                                     ),
//                                   ),
//                                   ProducTextHalfTitle(
//                                     devision: 2.5,
//                                     label: "Weight",
//                                     value: readyMadeProduct.weight.toString(),
//                                   ),
//                                 ])),
//                         Container(
//                             width: Get.width,
//                             child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: ProducTextHalfTitle(
//                                       devision: 1,
//                                       label: "Guard Film",
//                                       value:
//                                           readyMadeProduct.guardFilm.toString(),
//                                     ),
//                                   ),
//                                   ProducTextHalfTitle(
//                                     devision: 2.5,
//                                     label: "Pcs ",
//                                     value: readyMadeProduct.pcs.toString(),
//                                   ),
//                                 ])),
//                         Container(
//                             width: Get.width,
//                             child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: ProducTextHalfTitle(
//                                       devision: 3,
//                                       label: "Thickness",
//                                       value:
//                                           readyMadeProduct.thickness.toString(),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: ProducTextHalfTitle(
//                                       devision: 3,
//                                       label: "W",
//                                       value: readyMadeProduct.width.toString(),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: ProducTextHalfTitle(
//                                       devision: 3,
//                                       label: "L",
//                                       value: readyMadeProduct.length.toString(),
//                                     ),
//                                   ),
//                                 ])),

//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ProducTextHalfTitle extends StatelessWidget {
  final label;
  final value;
  final double devision;
  const ProducTextHalfTitle({Key key, this.label, this.value, this.devision})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
          width: Get.width / devision,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(10),
            width: Get.width / devision,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      label,
                      style: Constants.labelTextStyle
                          .copyWith(fontSize: size.width * 0.04),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width / 30,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      value,
                      style: Constants.valueTextStyle
                          .copyWith(fontSize: size.width * 0.04),
                    ),

                    // width: Get.width / 2,
                    // child: ProductTextTile(
                    //     label: "Product",
                    //     value:
                    //         readyMadeProduct.prodcutName.toString()),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class ProductTextTile extends StatelessWidget {
  const ProductTextTile({
    Key key,
    this.label,
    this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: Get.size.width,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  label.toUpperCase(),
                  style: Constants.labelTextStyle
                      .copyWith(fontSize: size.width * 0.04),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  value,
                  style: Constants.valueTextStyle
                      .copyWith(fontSize: size.width * 0.04),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
