import 'package:get/get.dart';

import 'package:webcv/app/modules/Services/AppService/controllers/app_service_controller.dart';

class AppServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppServiceController>(
      () => AppServiceController(),
    );
  }
}
