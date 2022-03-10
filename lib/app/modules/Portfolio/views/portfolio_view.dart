import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:webcv/app/modules/Portfolio/controllers/portfolio_controller.dart';
import 'package:webcv/common/widget/drawer.dart';
import 'package:webcv/common/widget/footer.dart';
import 'package:webcv/common/widget/header.dart';

import '../../../../main.dart';

class PortfolioView extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Header(),
      ),
      endDrawer: MediaQuery.of(context).size.width < 800 ? MyDrawer() : null,
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                    image: AssetImage('assets/images/port-im.png'),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    'My Portfolio',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width < 800
                  ? double.infinity
                  : MediaQuery.of(context).size.width * 0.7,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: MediaQuery.of(context).size.width < 800 ? 2 : 4,
                children: item(),
              ),
            ),
            Footer(
              scrollController: controller.scrollController,
            ),
          ],
        ),
      ),
    );
  }

  item() {
    return [
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(color: Colors.blueGrey),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(color: Colors.blueGrey),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(color: Colors.blueGrey),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(color: Colors.blueGrey),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(color: Colors.blueGrey),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(color: Colors.blueGrey),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(color: Colors.blueGrey),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(color: Colors.blueGrey),
      ),
    ];
  }
}
