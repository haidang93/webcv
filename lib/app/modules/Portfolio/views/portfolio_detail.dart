import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:webcv/app/modules/Portfolio/controllers/portfolio_controller.dart';
import 'package:webcv/common/widget/drawer.dart';
import 'package:webcv/common/widget/footer.dart';
import 'package:webcv/common/widget/header.dart';

import '../../../../main.dart';

class PortfolioDetail extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Header(),
      ),
      endDrawer: MediaQuery.of(context).size.width < 800 ? MyDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
