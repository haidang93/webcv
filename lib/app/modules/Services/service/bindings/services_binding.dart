import 'package:get/get.dart';

import 'package:webcv/app/modules/Services/service/controllers/services_controller.dart';

class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(
      () => ServicesController(),
    );
  }
}
