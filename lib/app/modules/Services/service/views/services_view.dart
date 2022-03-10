import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:webcv/app/modules/Services/service/controllers/services_controller.dart';
import 'package:webcv/common/const.dart';
import 'package:webcv/common/widget/drawer.dart';
import 'package:webcv/common/widget/footer.dart';
import 'package:webcv/common/widget/header.dart';

import '../../../../../main.dart';

class ServicesView extends GetView<ServicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Header(),
      ),
      endDrawer: MediaQuery.of(context).size.width < 800 ? MyDrawer() : null,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/bb.jpg'))),
          ),
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    'My services',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Obx(
                  () => SlideTransition(
                    position: controller.offsetAnimationApp,
                    child: InkWell(
                      onTap: () {
                        paging(PageName.appservice);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image:
                                AssetImage('assets/images/app-background.png'),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width < 800
                            ? double.infinity
                            : MediaQuery.of(context).size.width * 0.7,
                        child: MouseRegion(
                          onEnter: (s) {
                            controller.focus.value = PageName.appservice;
                          },
                          onExit: (s) {
                            controller.focus.value = '';
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            color: controller.focus.value == PageName.appservice
                                ? Colors.teal
                                : Colors.grey[700].withOpacity(0.7),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Text(
                                    'Learn more',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.teal[100],
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.all(10),

                                          decoration: BoxDecoration(
                                              color: Colors.teal,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/app-dev.png'))),
                                          // child: Image.asset(
                                          //   'images/web-dev.png',
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 5,
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Mobile App Development',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.teal[200],
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                'There are more than 100 billions apps downloaded in last year. People spent 70% of their online time on their mobile platform.\nCreate your app today to share your idea to the world.\n',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey[100],
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: SlideTransition(
                    position: controller.offsetAnimationWeb,
                    child: InkWell(
                      onTap: () {
                        paging(PageName.webservice);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image:
                                AssetImage('assets/images/web-background.png'),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width < 800
                            ? double.infinity
                            : MediaQuery.of(context).size.width * 0.7,
                        child: MouseRegion(
                          onEnter: (s) {
                            controller.focus.value = PageName.webservice;
                          },
                          onExit: (s) {
                            controller.focus.value = '';
                          },
                          child: Obx(
                            () => AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              color:
                                  controller.focus.value == PageName.webservice
                                      ? Colors.teal
                                      : Colors.grey[700].withOpacity(0.7),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Text(
                                      'Learn more',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.teal[100],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 5,
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Web App Design',
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.teal[200],
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'Whatever be your requirements and expectations, I can build a customized site precisely the way you want it to be!\nI know that all clients have their own uniquely individual needs. Thus, why I offer tailor-made services to ensure that clients get a personalized user experience.\n',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey[100],
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.all(10),

                                            decoration: BoxDecoration(
                                                color: Colors.teal,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/web-dev.png'))),
                                            // child: Image.asset(
                                            //   'images/web-dev.png',
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          'My tech stack',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      Container(
                        width: 800,
                        child: Row(
                          children: [
                            'assets/images/flutter.png',
                            'assets/images/dart.png',
                            'assets/images/firebase.png',
                            'assets/images/sqlite.png',
                          ]
                              .map((e) => Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(30),
                                      child: Image.asset(e),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Footer(
                  scrollController: controller.scrollController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
