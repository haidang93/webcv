import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePageController extends GetxController {
  BuildContext context;
  RxString focus = ''.obs;
  GlobalKey key = GlobalKey();
  RxDouble size = 0.0.obs;
  bool pageIsScrolling = false;
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((s) {
      final RenderBox renderBoxRed = key.currentContext.findRenderObject();
      size.value = renderBoxRed.size.height;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
