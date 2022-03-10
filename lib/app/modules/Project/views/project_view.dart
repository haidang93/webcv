import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:webcv/app/modules/Project/controllers/project_controller.dart';

import '../../../../main.dart';

class ProjectView extends GetView<ProjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProjectView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProjectView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
