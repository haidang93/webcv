import 'package:get/get.dart';
import 'package:webcv/app/modules/Services/WebService/controllers/web_service_controller.dart';

class WebServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebServiceController>(
      () => WebServiceController(),
    );
  }
}
