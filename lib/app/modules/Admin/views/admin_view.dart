import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:webcv/app/modules/Admin/controllers/admin_controller.dart';

import '../../../../main.dart';

class AdminView extends GetView<AdminController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdminView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
