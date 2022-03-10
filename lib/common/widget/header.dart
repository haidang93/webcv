import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../const.dart';

class Header extends StatefulWidget {
  Header({Key key}) : super(key: key);
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  RxString onFocus = ''.obs;

  Widget menu() {
    return Flexible(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PageName.home,
        PageName.about,
        PageName.services,
        PageName.portfolio,
        PageName.contact,
        PageName.project,
      ]
          .map(
            (e) => e == PageName.project ? projectButton(e) : button(e),
          )
          .toList(),
    ));
  }

  Widget button(String name) {
    return Flexible(
      child: Obx(
        () => MouseRegion(
          onEnter: (s) {
            onFocus.value = name;
          },
          onExit: (s) {
            onFocus.value = '';
          },
          child: Container(
            height: 60,
            width: 80,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedContainer(
                  width: 80,
                  height: onFocus.value == name ? 60 : 0,
                  curve: Curves.easeIn,
                  color: Colors.teal,
                  duration: Duration(milliseconds: 200),
                ),
                FlatButton(
                  height: 80,
                  minWidth: 100,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    paging(name);
                  },
                  child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.ease,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: onFocus.value == name
                              ? Colors.grey[50]
                              : Colors.grey[800]),
                      child: FittedBox(
                        child: Text(
                          name.capitalize,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget projectButton(String name) {
    return Flexible(
      child: Obx(() => AnimatedContainer(
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: onFocus.value == name
                  ? [
                      BoxShadow(
                        spreadRadius: 5,
                        blurRadius: 7,
                        color: Colors.teal[100],
                      )
                    ]
                  : [],
            ),
            child: MouseRegion(
              onEnter: (s) {
                onFocus.value = name;
              },
              onExit: (s) {
                onFocus.value = '';
              },
              child: AspectRatio(
                aspectRatio: 1.5,
                child: FlatButton(
                  color: Colors.teal[300],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal[400]),
                  ),
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
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            paging(PageName.home);
          },
          child: Container(
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                'NGUYEN HAI DANG',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      wordSpacing: -2),
                ),
              ),
            ),
          ),
        ),
        MediaQuery.of(context).size.width < 800 ? Container() : menu(),
      ],
    );
  }
}
