import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberCardTermController extends GetxController {
  ScrollController scrollController = ScrollController();
  //TODO: Implement MemberCardTermController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
