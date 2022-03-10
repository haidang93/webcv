import 'package:get/get.dart';

import '../controllers/member_card_policies_controller.dart';

class MemberCardPoliciesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemberCardPoliciesController>(
      () => MemberCardPoliciesController(),
    );
  }
}
