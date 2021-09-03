import 'package:get/get.dart';
import 'package:inventory_management/app/data/models/batch_filter_model.dart';
import 'package:inventory_management/app/data/services/batch_service.dart';
import 'package:inventory_management/meta/screens/batch/batch_screen.dart';
import 'package:inventory_management/meta/screens/home/home_screen.dart';

import 'orders_controller.dart';

class BatchController extends GetxController {
  checkToBatchOpen({int proPcs, int batchPcs, batchListIndex}) {
    if (proPcs <= batchPcs) {
    } else
      Get.snackbar("Batch Assign", "Batch not Opend ,Required ");
  }

  var batchScreenBack = true.obs;
  var taskComplete = false.obs;
  var batchListCurrentIndex = 0.obs;
  var dropDownPcsValue = "1".obs;
  var productPcsCount = 0.obs;
  var batchPcsCount = 0.obs;
  var remainingPcsCount = 0.obs;
  var batchListConst = List.empty(growable: true).obs;

  var selectedBatchList = List<ListBatch>.empty(growable: true).obs;
  var isDataLoaded = false.obs;
  var isBatchEnable = false.obs;
  var batch = "".obs;
  var isBatchSubmitClicked = false.obs;
  var batchList = List<ListBatch>.empty(growable: true).obs;
  BatchService _batchService = BatchService();
  final OrderController _orderController = Get.find();
  loadFilteredBatch(double thickness, double width, String color) {
    _batchService.getFilterBatches(thickness, width, color).then((value) {
      if (value.listData.isBlank) {
        batchList.value = List<ListBatch>.empty();
      } else {
        // value.listData.forEach((element) {
        //   if (element.pcs != null) {
        //     element.pcs = 10;
        //   }
        // });
        batchList.value = value.listData.toList();
      }
      isDataLoaded.value = true;
    });
  }

  onSubmitBatch(String productId) async {
    isBatchSubmitClicked.value = true;

    bool output = true;
    batchListConst.forEach((element) {
      if (element["isChecked"] == false) {
        output = false;
      }
    });
    Future.delayed(Duration(seconds: 2), () async {
      isBatchSubmitClicked.value = false;
      if (output == true) {
        taskComplete.value = true;

        Get.snackbar("Batch", "Batch Assign is Complete");
        await _batchService.submitBatch(
          BatchUpdateModel(
              pcsCut: batchListConst.length,
              lengthPerPcsCut: _orderController.currentOrder.value
                  .products[_orderController.productIndex.value].length,
              approxWeightPerMM: batchList[batchListCurrentIndex.value].weight,
              batchId: batchList[batchListCurrentIndex.value].id),
        );
        if (remainingPcsCount > 0) {
          batchScreenBack.value = false;
          print("Batch Index :${batchListCurrentIndex.value}");
          print("Submited Pcs ${batchListConst.length}");
          print(
              "Update Batch Pcs Value ${batchList[batchListCurrentIndex.value].pcs - batchListConst.length}");

          print("Batch weight" +
              batchList[batchListCurrentIndex.value].weight.toString());
          print("Product id" +
              _orderController.currentOrder.value
                  .products[_orderController.productIndex.value].productId
                  .toString());

          //updating real value of batch peacs count after assign

          batchList[batchListCurrentIndex.value].pcs -= batchListConst.length;

          Get.back();
          batchListConst.clear();
//adding remaing pcs count to product pcs for geting updated pcs of product
          productPcsCount.value = remainingPcsCount.value;

//clearing obs value of remaing count of peaces
          batchPcsCount.value -= remainingPcsCount.value;
          remainingPcsCount.value = 0;
          Get.off(BatchScreen());
          //  Get.off(BatchScreen());

        } else {
          batchScreenBack.value = true;
          //submit batch list method will run here, when remaing peaces will 0;
          _orderController
              .orderList[_orderController.currentOrderIndex.value]
              .products[_orderController.productIndex.value]
              .isproductBatchSubmied = true;
          print("order ID" + _orderController.currentOrder.value.orderId);
          print("Selected Batch Len");
          print(selectedBatchList.length);
          // print("productId" +
          //     _orderController.currentOrder.value
          //         .products[_orderController.productIndex.value].productId);
          await submitBatch(
              _orderController.currentOrder.value.id,
              selectedBatchList,
              _orderController.currentOrder.value
                  .products[_orderController.productIndex.value].productId);

          selectedBatchList.clear();
          _orderController
              .currentOrder
              .value
              .products[_orderController.productIndex.value]
              .isproductBatchSubmied = true;
          Get.back();
          Get.offAll(HomeScreen());
        }
      } else
        Get.snackbar("Batch", "Please Complete this pcs ");
    });
    taskComplete.value = false;
  }

  submitBatch(String orderId, List<ListBatch> batch, String productId) async {
    List<Map<String, String>> batchMap = batch
        .map((e) => {"batch_no": e.batchNumber, "batch_id": e.id})
        .toList();

    print("Batch Map");
    batchMap.forEach((element) {
      print(element["batch_no"]);
      print("batch id" + element["batch_id"]);
    });
    await _batchService.addBatchListToProduct(orderId, productId, batchMap);
    Get.snackbar("Batch Submited", "message");
  }
}
