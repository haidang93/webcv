import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:webcv/app/modules/Services/AppService/controllers/app_service_controller.dart';

import '../../../../../main.dart';

class AppServiceView extends GetView<AppServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppServiceView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AppServiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
