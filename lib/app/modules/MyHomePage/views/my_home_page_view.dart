import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webcv/app/data/models/home_item_model.dart';

import 'package:webcv/app/modules/MyHomePage/controllers/my_home_page_controller.dart';
import 'package:webcv/common/const.dart';
import 'package:webcv/common/widget/drawer.dart';
import 'package:webcv/common/widget/footer.dart';
import 'package:webcv/common/widget/header.dart';
import 'package:webcv/main.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePageView extends GetView<MyHomePageController> {
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        key: controller.key,
        title: Header(),
      ),
      endDrawer: MediaQuery.of(controller.context).size.width < 800
          ? MyDrawer()
          : null,
      body: Container(
        alignment: Alignment.topCenter,
        child: Obx(
          () => Stack(
            children: [
              Container(
                height: MediaQuery.of(controller.context).size.height -
                    controller.size.value,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.lerp(
                        Alignment.center, Alignment.centerRight, 0.4),
                    image: AssetImage('assets/images/home3.jpg'),
                  ),
                ),
              ),
              ListView(
                key: PageStorageKey('home'),
                shrinkWrap: true,
                controller: controller.scrollController,
                children: [
                  Container(
                    alignment:
                        MediaQuery.of(controller.context).size.width < 800
                            ? Alignment.bottomLeft
                            : Alignment.centerLeft,
                    height: MediaQuery.of(controller.context).size.height -
                        controller.size.value,
                    child: header(),
                  ),
                  Container(
                    color: Colors.white,
                    child: homeContent(),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  Footer(
                    scrollController: controller.scrollController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  header() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        alignment: MediaQuery.of(controller.context).size.width < 800
            ? Alignment.bottomLeft
            : Alignment.centerLeft,
        padding: EdgeInsets.all(50),
        height: double.infinity,
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'EXPERIANCE THE DIFFERENCE\n\n',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              Text(
                'Hi,\nI\'m Nguyen Hai Dang\nMobile App Developer',
                style: GoogleFonts.roboto(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey[700]),
              ),
              Text(''),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  hireMeButton(),
                  SizedBox(width: 30),
                  cvButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  cvButton() {
    return Obx(() => MouseRegion(
          onEnter: (s) {
            controller.focus.value = 'cv';
          },
          onExit: (s) {
            controller.focus.value = '';
          },
          child: Container(
            height: 50,
            width: 170,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.teal[300]),
                borderRadius: BorderRadius.circular(8)),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                AnimatedContainer(
                  width: double.infinity,
                  height: controller.focus.value == 'cv' ? 50 : 0,
                  curve: Curves.bounceOut,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8)),
                  duration: Duration(milliseconds: 800),
                ),
                FlatButton(
                  height: double.infinity,
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('download items')
                        .doc('CV')
                        .get()
                        .then((item) async {
                      if (await canLaunch(item.data()['url'])) {
                        await launch(
                          item.data()['url'],
                          forceSafariVC: false,
                          forceWebView: false,
                        );
                      }
                    });
                  },
                  child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.ease,
                      style: TextStyle(
                          fontSize: 18,
                          color:
                              MediaQuery.of(controller.context).size.width < 800
                                  ? Colors.grey[400]
                                  : controller.focus.value == 'cv'
                                      ? Colors.grey[50]
                                      : Colors.grey[800]),
                      child: Text(
                        'Download CV',
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  hireMeButton() {
    return Obx(() => MouseRegion(
          onEnter: (s) {
            controller.focus.value = 'hire';
          },
          onExit: (s) {
            controller.focus.value = '';
          },
          child: Container(
            height: 50,
            width: 170,
            decoration: BoxDecoration(
                color: Colors.teal[300],
                borderRadius: BorderRadius.circular(8)),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                AnimatedContainer(
                  width: controller.focus.value == 'hire' ? 170 : 0,
                  height: double.infinity,
                  curve: Curves.bounceOut,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8)),
                  duration: Duration(milliseconds: 800),
                ),
                FlatButton(
                  height: double.infinity,
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    paging(PageName.contact);
                  },
                  child: Text(
                    'Hire Me',
                    style: TextStyle(fontSize: 18, color: Colors.grey[50]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  homeContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),
          Text(
            'My services',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Freelance Mobile App Programmer & Web Designer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          MediaQuery.of(controller.context).size.width < 800
              ? Column(
                  children: item(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item().map((e) => Expanded(child: e)).toList(),
                )
          // StaggeredGridView.countBuilder(
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: 3,
          //     crossAxisCount: 3,
          //     itemBuilder: (context, index) => item()[index],
          //     staggeredTileBuilder: (index) => new StaggeredTile.fit(1),
          //   ),
        ],
      ),
    );
  }

  List<Widget> item() {
    return [
      HomeItem(
        photo: 'assets/images/phone.png',
        title: 'Mobile App Development\n',
        content:
            'I offer beautiful UI, best performance with fast development time to bring your ideas into reality.\n',
        button: 'Learn more',
        routes: PageName.appservice,
      ),
      HomeItem(
        photo: 'assets/images/web.png',
        title: 'Website Design\n',
        content:
            'A good website will strengthens your brand, my service is to create outstanding professional yet simple and easy to use.\n',
        button: 'Learn more',
        routes: PageName.webservice,
      ),
      HomeItem(
        photo: 'assets/images/port.png',
        title: 'My Previous Works\n',
        content:
            'With Flutter you can launch your products faster by coding once and you can release for Android, iOS and even Web App. Please take your time and view my portfolio.\n',
        button: 'View portfolio',
        routes: PageName.portfolio,
      ),
    ]
        .map(
          (e) => Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(e.photo),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      e.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      e.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[600],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: MouseRegion(
                        onEnter: (s) {
                          controller.focus.value = e.routes;
                        },
                        onExit: (s) {
                          controller.focus.value = '';
                        },
                        child: Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.teal[300],
                              borderRadius: BorderRadius.circular(8)),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Obx(() => AnimatedContainer(
                                    width: controller.focus.value == e.routes
                                        ? 130
                                        : 0,
                                    height: double.infinity,
                                    curve: Curves.bounceOut,
                                    decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.circular(8)),
                                    duration: Duration(milliseconds: 800),
                                  )),
                              FlatButton(
                                height: double.infinity,
                                minWidth: double.infinity,
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {
                                  paging(e.routes);
                                },
                                child: FittedBox(
                                  child: Text(
                                    e.button,
                                    style: TextStyle(color: Colors.grey[50]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
