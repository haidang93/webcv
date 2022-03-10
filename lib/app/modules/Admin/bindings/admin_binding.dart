import 'package:get/get.dart';

import 'package:webcv/app/modules/Admin/controllers/admin_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(
      () => AdminController(),
    );
  }
}
