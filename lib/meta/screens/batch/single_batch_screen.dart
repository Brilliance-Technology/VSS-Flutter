import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/controllers/batch_controller.dart';
import 'package:inventory_management/common/widgets/svg_background.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';

class SingleBatchScree extends StatefulWidget {
  final String batch;
  final double weight;
  final double thickness;
  final int pcs;
  final double width;
  final String productId;
  final double len;

  SingleBatchScree(
      {Key key,
      this.batch,
      this.weight,
      this.thickness,
      this.pcs,
      this.len,
      this.width,
      this.productId})
      : super(key: key);

  @override
  _SingleBatchScreeState createState() => _SingleBatchScreeState();
}

class _SingleBatchScreeState extends State<SingleBatchScree> {
  final BatchController _batchController = Get.find();

  // bool taskComplete = false;

  Future<bool> _willPopCallback() async {
    Get.snackbar('Error', "Please Complete the pcs and Submit");
    // await showDialog or Show add banners or whatever
    // then
    return _batchController
        .taskComplete.value; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // _batchController.dropDownPcsValue.value =
    //     _batchController.batchListConst[0].toString();
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Stack(
          children: [
            Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
              floatingActionButton: ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: kButtonColorPrimary,
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    _batchController.onSubmitBatch(widget.productId);
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.width / 80,
                          horizontal: size.width / 50),
                      child: Obx(
                        () => Text(
                          _batchController.remainingPcsCount > 0
                              ? "Submit And Next"
                              : "Submit",
                          style: Constants.labelTextStyle.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ))),
              appBar: appBar(
                  title: "Batch Assign",
                  leadingWidget: BackButton(
                    color: Colors.white,
                  )),
              backgroundColor: kPrimaryColorDark,
              body: Container(
                height: size.height,
                decoration: BoxDecoration(
                    color: Color(0xffFBFEFE),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          // Text(
                          //   "BATCH NO.".toString(),
                          //   style: Constants.labelTextStyle,
                          // ),
                          Text(
                            widget.batch.toString(),
                            style: Constants.labelTextStyle
                                .copyWith(color: kPrimaryColorDark),
                          ),
                          Spacer(
                            flex: 10,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23)),
                        elevation: 8,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: kPrimaryColorLight,
                              borderRadius: BorderRadius.circular(23)),
                          child: Wrap(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Spacer(
                              //   flex: 1,
                              // ),
                              SingleBatchTextTile(
                                label: "Thickness",
                                value: widget.thickness.toStringAsFixed(2),
                              ),
                              // Spacer(
                              //   flex: 1,
                              // ),
                              SingleBatchTextTile(
                                label: "Length",
                                value: widget.len.toStringAsFixed(2),
                              ),
                              // Spacer(
                              //   flex: 1,
                              // ),
                              SingleBatchTextTile(
                                label: "Width",
                                value: widget.width.toStringAsFixed(2),
                              ),
                              // Spacer(),
                              SizedBox(
                                width: size.width * 0.0,
                              ),
                              SingleBatchTextTile(
                                label: " Pcs ",
                                value: widget.pcs.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Obx(() => _batchController.remainingPcsCount.value > 0
                        ? Container(
                            child: Row(
                              children: [
                                Spacer(),
                                Text(
                                  "Remaining Pcs : ",
                                  style: Constants.labelTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                    "${_batchController.remainingPcsCount.value}",
                                    style: Constants.valueTextStyle
                                        .copyWith(fontSize: 18)),
                                Spacer(
                                  flex: 8,
                                )
                              ],
                            ),
                          )
                        : SizedBox()),
                    Spacer(),
                    Container(
                      height: size.height / 2.5,
                      child: BatchPcsComponent(),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => _batchController.isBatchSubmitClicked.value == true
                ? Container(
                    color: Colors.black.withOpacity(0.3),
                    width: size.width,
                    height: size.height,
                    child: Center(
                      child: Container(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                          )),
                    ),
                  )
                : SizedBox())
          ],
        ));
  }
}

class BatchPcsComponent extends StatefulWidget {
  BatchPcsComponent({Key key}) : super(key: key);

  @override
  _BatchPcsComponentState createState() => _BatchPcsComponentState();
}

class _BatchPcsComponentState extends State<BatchPcsComponent> {
  final BatchController _batchController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Obx(
        () => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 0,
                crossAxisCount: 2,
                childAspectRatio: 4),
            itemCount: _batchController.batchListConst.length,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      splashRadius: 25,
                      activeColor: kPrimaryColorDark,
                      value: _batchController.batchListConst[index]
                          ["isChecked"],
                      onChanged: (bool) {
                        _batchController.batchListConst.toList()[index]
                            ["isChecked"] = bool;
                        setState(() {});
                      }),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 8,
                      shadowColor: Colors.black.withOpacity(0.5),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.width * 0.01),
                        width: size.width / 2,
                        decoration: BoxDecoration(
                            color: kPrimaryColorLight
                                .withOpacity(0.8), // Color(0xffF5FAFD),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          _batchController.batchListConst[index]["pcsCount"]
                              .toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              );
            }),
      ),
    );
  }
}

class SingleBatchTextTile extends StatelessWidget {
  final String label;
  final String value;
  SingleBatchTextTile({this.label, this.value});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label.toString(),
            style: Constants.labelTextStyle.copyWith(
                fontSize: 12,
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: size.width / 80,
          ),
          Card(
            elevation: 11,
            shadowColor: Colors.grey.withOpacity(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
            child: Container(
              width: Get.size.width / 4,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffF5FAFD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value.toString(),
                style: Constants.labelTextStyle
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
    );
  }
}
