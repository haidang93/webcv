import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../const.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  GlobalKey key = GlobalKey();
  RxString onFocus = ''.obs;
  double width;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      width = key.currentContext.size.width;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: key,
      child: items(),
    );
  }

  Widget items() {
    return ListView(
      children: [
        'back',
        PageName.home,
        PageName.about,
        PageName.services,
        PageName.portfolio,
        PageName.contact,
        PageName.project,
      ]
          .map(
            (e) => e == 'back'
                ? backButton()
                : e == PageName.project
                    ? projectButton(e)
                    : button(e),
          )
          .toList(),
    );
  }

  Widget backButton() {
    return FlatButton(
      padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [Icon(Icons.arrow_forward_ios)],
      ),
    );
  }

  Widget button(String name) {
    return Column(
      children: [
        Obx(
          () => MouseRegion(
            onEnter: (s) {
              onFocus.value = name;
            },
            onExit: (s) {
              onFocus.value = '';
            },
            child: Container(
              height: 60,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  AnimatedContainer(
                    width: onFocus.value == name ? width : 0,
                    height: 60,
                    curve: Curves.easeIn,
                    color: Colors.teal,
                    duration: Duration(milliseconds: 200),
                  ),
                  FlatButton(
                    height: 80,
                    minWidth: double.infinity,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.pop(context);
                      paging(name == PageName.home ? '' : name);
                    },
                    splashColor: Colors.teal,
                    child: AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.ease,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: onFocus.value == name
                                ? Colors.grey[50]
                                : Colors.grey[800]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  name.capitalize,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.teal.withOpacity(0.2),
        ),
      ],
    );
  }

  Widget projectButton(String name) {
    return Column(
      children: [
        Obx(
          () => Container(
            padding: EdgeInsets.all(20),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: onFocus.value != name
                    ? null
                    : [
                        BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 7,
                          color: Colors.teal[100],
                        )
                      ],
              ),
              child: MouseRegion(
                onEnter: (s) {
                  onFocus.value = name;
                },
                onExit: (s) {
                  onFocus.value = '';
                },
                child: AspectRatio(
                  aspectRatio: 5,
                  child: FlatButton(
                    color: Colors.teal[300],
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.teal[400]),
                        borderRadius: BorderRadius.circular(10)),
                    height: double.infinity,
                    onPressed: () {
                      paging(name);
                    },
                    child: FittedBox(
                      child: Text(
                        name.capitalize,
                        style: TextStyle(color: Colors.grey[50]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
            width: double.infinity,
            height: 1,
            color: Colors.teal.withOpacity(0.2)),
      ],
    );
  }
}
