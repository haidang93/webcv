import 'package:get/get.dart';

import 'package:webcv/app/modules/Project/controllers/project_controller.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectController>(
      () => ProjectController(),
    );
  }
}
