import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';
import 'package:inventory_management/app/controllers/batch_controller.dart';
import 'package:inventory_management/meta/screens/batch/single_batch_screen.dart';
import 'package:inventory_management/meta/widgets/app_bar.dart';

class BatchScreen extends StatefulWidget {
  final String productId;
  final String orderId;
  BatchScreen({this.productId, this.orderId});

  @override
  _BatchScreenState createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  final BatchController _batchController = Get.find();
  int _isSelected = 0;
  Future<bool> _willPopCallback() async {
    if (_batchController.batchList.isEmpty) {
      return true;
    } else {
      Get.snackbar('Error', "Please Complete the pcs.");
      // await showDialog or Show add banners or whatever
      // then
      return _batchController.batchScreenBack.value;
    } // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ElevatedButton(
            style: TextButton.styleFrom(
                backgroundColor: kButtonColorPrimary,
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(8))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: size.width / 50),
              child: Text(
                "Submit",
                style: Constants.labelTextStyle.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ),
            onPressed: () {
              // _batchController.batchList.forEach((element) {
              //   element.isSelected = false;
              // });
              // _batchController.submitBatch(
              //     orderId,
              //     _batchController.selectedBatchList,
              //     productId);
              print("Selected Index" + _isSelected.toString());
              _batchController.batchPcsCount.value =
                  _batchController.batchList[_isSelected].pcs;
              if (_batchController.batchPcsCount.value == 0) {
                Get.snackbar("Batch", "This Batch is Finish Select Next Batch");
              } else {
                _batchController.selectedBatchList
                    .add(_batchController.batchList[_isSelected]);
                if (_batchController.productPcsCount.value <=
                    _batchController.batchPcsCount.value) {
                  _batchController.batchListConst.value = List.generate(
                      _batchController.productPcsCount.value + 1,
                      (index) => {"pcsCount": "$index", "isChecked": false});
                  _batchController.batchListConst.removeAt(0);
                  Get.to(SingleBatchScree(
                    thickness:
                        _batchController.batchList[_isSelected].thickness,
                    len: _batchController.batchList[_isSelected].length,
                    pcs: _batchController.batchList[_isSelected].pcs,
                    weight: _batchController.batchList[_isSelected].weight,
                    batch: _batchController.batchList[_isSelected].batchNumber,
                    width: _batchController.batchList[_isSelected].width,
                    productId: widget.productId,
                  ));
                } else {
                  _batchController.batchListCurrentIndex.value = _isSelected;
                  _batchController.remainingPcsCount.value =
                      _batchController.productPcsCount.value -
                          _batchController.batchPcsCount.value;
                  _batchController.batchListConst.value = List.generate(
                      _batchController.batchPcsCount.value + 1,
                      (index) => {"pcsCount": "$index", "isChecked": false});
                  _batchController.batchListConst.removeAt(0);
                  Get.to(SingleBatchScree(
                    thickness:
                        _batchController.batchList[_isSelected].thickness,
                    len: _batchController.batchList[_isSelected].length,
                    pcs: _batchController.batchList[_isSelected].pcs,
                    weight: _batchController.batchList[_isSelected].weight,
                    batch: _batchController.batchList[_isSelected].batchNumber,
                    width: _batchController.batchList[_isSelected].width,
                    productId: widget.productId,
                  ));
                }
              }
            },
          ),
          appBar: appBar(
              title: "Batches",
              leadingWidget: BackButton(
                color: Colors.white,
              )),
          backgroundColor: kPrimaryColorDark,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width / 80),
            decoration: BoxDecoration(
                color: Color(0xffFBFEFE),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Obx(
              () => _batchController.isDataLoaded.value == false
                  ? Center(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          width: Get.width,
                          height: Get.height,
                          child: CircularProgressIndicator()),
                    )
                  : _batchController.batchList.isEmpty
                      ? Container(
                          height: size.height,
                          width: size.height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: Center(
                            child: Text(
                              "No Batches found",
                              style: Constants.labelTextStyle,
                            ),
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height / 85,
                              ),
                              Flexible(
                                child: Container(
                                  width: Get.width,
                                  child: ListView.builder(
                                      // gridDelegate:
                                      // SliverGridDelegateWithFixedCrossAxisCount(
                                      //     crossAxisCount: 1),
                                      itemCount:
                                          _batchController.batchList.length,
                                      itemBuilder: (context, index) {
                                        return BatchGridTile(
                                          index: index,
                                          groupValue: _isSelected == index,
                                          onTap: () {
                                            setState(() {
                                              _isSelected = index;
                                            });
                                          },
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
          )),
    );
  }
}

class BatchGridTile extends StatefulWidget {
  BatchGridTile({this.index, this.groupValue, this.onTap});
  final int index;
  final bool groupValue;
  final Function onTap;

  @override
  _BatchGridTileState createState() => _BatchGridTileState();
}

class _BatchGridTileState extends State<BatchGridTile> {
  final BatchController _batchController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 80, vertical: 2),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          elevation: 3,
          child: Container(
            // height: size.height / 20,
            padding: EdgeInsets.symmetric(vertical: 10),
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: Color(0xffE9EDEF),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.groupValue == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Icon(
                                Icons.radio_button_checked_rounded,
                                color: kPrimaryColorDark,
                              )),
                        ],
                      )
                    : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Icon(Icons.radio_button_off_rounded,
                                color: kPrimaryColorDark)),
                      ]),
                // Spacer(),
                // Container(
                //     padding: EdgeInsets.symmetric(horizontal: size.width / 30),
                //     child: Text(
                //       "Batch",
                //       style: Constants.labelTextStyle
                //           .copyWith(fontSize: size.width * 0.04),
                //     )),
                Expanded(
                  child: Container(
                      // width: Get.width

                      child: Text(
                    "${_batchController.batchList[widget.index].batchNumber}",
                    style: Constants.valueTextStyle
                        .copyWith(fontSize: size.width * 0.028),
                  )),
                ),
                //Spacer(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 30),
                    child: Text(
                      "Weight -",
                      style: Constants.labelTextStyle.copyWith(
                          fontSize: size.width * 0.036,
                          color: kPrimaryColorDark,
                          fontWeight: FontWeight.normal),
                    )),
                Container(
                    //  width: Get.width,
                    child: Obx(
                  () => Text(
                    "${_batchController.batchList[widget.index].weight}",
                    style: Constants.valueTextStyle.copyWith(
                        fontSize: size.width * 0.035,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                )),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 30),
                    child: Text(
                      "Pcs",
                      style: Constants.labelTextStyle.copyWith(
                          fontSize: size.width * 0.035,
                          color: kPrimaryColorDark,
                          fontWeight: FontWeight.normal),
                    )),
                Container(
                    //  width: Get.width,
                    child: Obx(
                  () => Text(
                    "${_batchController.batchList[widget.index].pcs}",
                    style: Constants.valueTextStyle
                        .copyWith(fontSize: size.width * 0.035),
                  ),
                )),
                SizedBox(
                  width: 10,
                )
                //  Spacer(),
                // Expanded(
                //   child: Container(
                //       child: Text(
                //     "${_batchController.batchList[widget.index].weight.toStringAsFixed(2)}",
                //     style: Constants.valueTextStyle
                //         .copyWith(fontSize: size.width * 0.028),
                //   )),
                // ),
                // Spacer(
                //   flex: 2,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
