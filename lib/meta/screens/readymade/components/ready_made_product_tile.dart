import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/data/models/ready_made_model.dart';
import 'package:inventory_management/meta/screens/readymade/components/ready_made_text_title.dart';
import 'package:inventory_management/meta/screens/readymade/components/ready_product_details.dart';

class ReadyMadeProductTile extends StatelessWidget {
  final ReadyMade readyMade;
  ReadyMadeProductTile({this.readyMade});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 4,
      child: GestureDetector(
          onTap: () {
            Get.to(() => ReadyProductDetails(
                  readyMadeProduct: readyMade,
                ));
            // Get.to(() => ReadyMadeProductDetailScreen(
            //       readyMadeProduct: readyMade,
            //     ));
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffE9EDEF),
                    borderRadius: BorderRadius.circular(23)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        width: size.width / 3.5,
                        height: size.width / 3.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.gif",
                            image:
                                "https://d12oja0ew7x0i8.cloudfront.net/images/Article_Images/ImageForArticle_16788(1).jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Container(
                        height: size.height,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Spacer(
                                  flex: 4,
                                ),
                                Text(
                                  "Product",
                                  style: TextStyle(
                                      fontSize: size.width * 0.034,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                Text(readyMade.selectProduct.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: size.width * 0.03,
                                      color: kPrimaryColorTextDark,
                                    )),
                                Spacer()
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Spacer(),
                                Text(
                                  "Company",
                                  style: TextStyle(
                                      fontSize: size.width * 0.026,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                Text(readyMade.company.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: size.width * 0.026,
                                      color: kPrimaryColorTextDark,
                                    )),
                                Spacer(
                                  flex: 5,
                                )
                              ],
                            ),

                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              shadowColor: Colors.grey.withOpacity(0.5),
                              child: Container(
                                width: size.width / 1.5,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width / 30,
                                    vertical: size.width / 30),
                                decoration: BoxDecoration(
                                    color: kPrimaryColorLight,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ReadyMadeTextTile(
                                              label: "Len",
                                              value: readyMade.length != null
                                                  ? readyMade.length
                                                      .toStringAsFixed(2)
                                                  : "null"),
                                        ),
                                        Expanded(
                                          child: ReadyMadeTextTile(
                                              label: "Thickness ",
                                              value: readyMade.thickness != null
                                                  ? readyMade.thickness
                                                      .toStringAsFixed(2)
                                                  : "null"),
                                        ),
                                        Expanded(
                                          child: ReadyMadeTextTile(
                                              label: "width",
                                              value: readyMade.width != null
                                                  ? readyMade.width
                                                      .toStringAsFixed(2)
                                                  : "null"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ReadyMadeTextTile(
                                              label: "Pcs",
                                              value: readyMade.pcs != null
                                                  ? readyMade.pcs
                                                      .toStringAsFixed(2)
                                                  : "null"),
                                        ),
                                        Expanded(
                                          child: ReadyMadeTextTile(
                                              label: "Weight",
                                              value: readyMade.weight != null
                                                  ? readyMade.weight
                                                      .toStringAsFixed(2)
                                                  : "null"),
                                        ),
                                        Expanded(
                                          child: ReadyMadeTextTile(
                                              label: "TopColor",
                                              value: readyMade.topcolor
                                                  .toString()),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 3,
                            ),
                            // ReadyMadeTextTile(
                            //     label: "Grade",
                            //     value: readyMade.grade.toString()),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
