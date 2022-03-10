import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';

class ServicesController extends GetxController
    with SingleGetTickerProviderMixin {
  RxString focus = ''.obs;
  AnimationController appController;
  Animation<Offset> offsetAnimationApp;
  Animation<Offset> offsetAnimationWeb;
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    appController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    offsetAnimationApp = Tween<Offset>(begin: Offset(1.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: appController, curve: Curves.easeInOutBack));
    offsetAnimationWeb = Tween<Offset>(begin: Offset(-1.5, 0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: appController, curve: Curves.easeInOutBack));
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      appController..forward();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
