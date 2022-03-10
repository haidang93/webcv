import 'package:get/get.dart';

import 'package:webcv/app/modules/MyHomePage/controllers/my_home_page_controller.dart';

class MyHomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyHomePageController>(
      () => MyHomePageController(),
    );
  }
}
