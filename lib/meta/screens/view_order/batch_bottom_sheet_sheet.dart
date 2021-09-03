import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/controllers/batch_controller.dart';
import 'package:inventory_management/app/data/models/product.dart';
import 'package:inventory_management/meta/screens/batch/batch_screen.dart';
import 'package:page_transition/page_transition.dart';

class BatchBottomSheetContent extends StatelessWidget {
  final Product product;
  final String orderId;
  final BatchController _batchController = Get.put(BatchController());
  BatchBottomSheetContent({this.product, this.orderId});
  @override
  build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 2,
      width: size.width,
      child: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: size.width / 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height / 80),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                      _batchController.isBatchEnable.value = false;
                    }),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColorTextDark,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Text(
                    product.selectProduct.toString(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColorLight,
                    borderRadius: BorderRadius.circular(23)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: BatchBottomSheetTextTile(
                            label: "Thickness",
                            value: product.thickness.toString(),
                            deivsion: 3,
                          ),
                        ),
                        Expanded(
                          child: BatchBottomSheetTextTile(
                            label: "Length",
                            value: product.length.toString(),
                            deivsion: 3,
                          ),
                        ),
                        Expanded(
                          child: BatchBottomSheetTextTile(
                            label: "Width",
                            value: product.width.toString(),
                            deivsion: 3,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: BatchBottomSheetTextTile(
                            label: "Pcs",
                            value: product.pcs.toString(),
                            deivsion: 3,
                          ),
                        ),
                        Expanded(
                          child: BatchBottomSheetTextTile(
                            label: "Weight",
                            value: product.weight.toString(),
                            deivsion: 2,
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Obx(() => _batchController.isBatchEnable.value == true
                ? BatchBottomSheetTextTile(
                    label: "Batch",
                    value: _batchController.batch.value,
                    deivsion: 2,
                  )
                : SizedBox()),
            CustomTextButton(
              color: product.topcolor,
              width: product.width,
              thickness: product.thickness,
              productId: product.id,
              orderId: orderId,
              productPcs: product.pcs,
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class BatchBottomSheetTextTile extends StatelessWidget {
  const BatchBottomSheetTextTile(
      {Key key, this.label, this.value, this.deivsion, this.batchController})
      : super(key: key);
  final BatchController batchController;
  final String label;
  final String value;
  final int deivsion;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: Get.width / deivsion ?? Get.width,
        child: Column(
          children: [
            SizedBox(
              width: Get.width / 20,
            ),
            Text(label,
                style: TextStyle(
                        fontSize: 12, color: Colors.black.withOpacity(0.7))
                    .copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.03)),
            Card(
              elevation: 11,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)),
              child: Container(
                width: Get.size.width / 4,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  value.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4C7088)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  CustomTextButton(
      {Key key,
      this.productPcs,
      this.thickness,
      this.width,
      this.color,
      this.productId,
      this.orderId})
      : super(key: key);
  final BatchController _batchController = Get.put(BatchController());
  final double thickness, width;
  final String color;
  final String productId;
  final String orderId;
  final int productPcs;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _batchController.productPcsCount.value = productPcs;
        print(_batchController.productPcsCount.value);
        //_batchController.loadFilteredBatch(3.5, 1234.5, "black");
        _batchController.loadFilteredBatch(thickness, width, color);
        Get.back();
        Navigator.push(
            context,
            PageTransition(
              child: BatchScreen(
                orderId: orderId,
                productId: productId,
              ),
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 500),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kButtonColorPrimary,
        ),
        padding: EdgeInsets.all(10),
        child: Text(
          "Show Batches",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
