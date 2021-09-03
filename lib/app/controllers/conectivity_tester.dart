import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityTester extends GetxController {
  var connectionStatus = 'Unknown'.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        connectionStatus.value = result.toString();
        print(result.toString());
        Get.snackbar(' Internet Connection', connectionStatus.value,
            colorText: Colors.white60,
            backgroundColor: Colors.black,
            snackPosition: SnackPosition.BOTTOM);
        break;
      default:
        connectionStatus.value = 'Failed to get connectivity.';
        Get.snackbar('Internet Connection', connectionStatus.value,
            colorText: Colors.white60,
            backgroundColor: Colors.black,
            snackPosition: SnackPosition.BOTTOM);
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(result);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
