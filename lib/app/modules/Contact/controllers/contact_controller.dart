import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class ContactController extends GetxController {
  BuildContext context;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {}
  @override
  void onReady() {}
  @override
  void onClose() {}
}
