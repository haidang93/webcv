import 'package:get/get.dart';

import 'package:webcv/app/modules/Portfolio/controllers/portfolio_controller.dart';

class PortfolioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PortfolioController>(
      () => PortfolioController(),
    );
  }
}
