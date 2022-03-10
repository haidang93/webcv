import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:webcv/app/modules/About/controllers/about_controller.dart';
import 'package:webcv/common/widget/drawer.dart';
import 'package:webcv/common/widget/footer.dart';
import 'package:webcv/common/widget/header.dart';

import '../../../../main.dart';

class AboutView extends GetView<AboutController> {
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
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 800,
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 16 / 6,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.center,
                        image: AssetImage('assets/images/me2.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('myBio')
                    .doc('about')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData)
                    return Container(
                      width: 800,
                      color: Colors.grey[200],
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data['motto'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              snapshot.data['bio'],
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                },
              ),
              Footer(
                scrollController: controller.scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
