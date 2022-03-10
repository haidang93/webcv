import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webcv/app/modules/memberCardPolicies/controllers/member_card_policies_controller.dart';
import 'package:webcv/common/widget/drawer.dart';
import 'package:webcv/common/widget/footer.dart';
import 'package:webcv/common/widget/header.dart';

import '../controllers/member_card_term_controller.dart';

class MemberCardTermView extends GetView<MemberCardTermController> {
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width < 800 ? 30 : 100,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms of Service',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(termOfService),
                ],
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
}
