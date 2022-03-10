import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webcv/common/widget/drawer.dart';
import 'package:webcv/common/widget/footer.dart';
import 'package:webcv/common/widget/header.dart';

import '../controllers/member_card_policies_controller.dart';

class MemberCardPoliciesView extends GetView<MemberCardPoliciesController> {
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
                    'Privacy Policy',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(privacyPolicy),
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
