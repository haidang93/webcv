import 'package:get/get.dart';

import '../controllers/member_card_term_controller.dart';

class MemberCardTermBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemberCardTermController>(
      () => MemberCardTermController(),
    );
  }
}
