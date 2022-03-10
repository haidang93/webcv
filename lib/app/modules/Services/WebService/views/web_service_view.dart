import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webcv/app/modules/Services/WebService/controllers/web_service_controller.dart';

import '../../../../../main.dart';

class WebServiceView extends GetView<WebServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebServiceView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'WebServiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
