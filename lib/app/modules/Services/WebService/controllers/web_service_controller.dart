import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';

class WebServiceController extends GetxController {
  ValueChanged<PageToLoad> paging;
  //TODO: Implement WebServiceController

  final count = 0.obs;
  @override
  void onInit() {}
  @override
  void onReady() {}
  @override
  void onClose() {}
  void increment() => count.value++;
}
