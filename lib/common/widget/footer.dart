import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../const.dart';

class Footer extends StatefulWidget {
  const Footer({
    Key key,
    this.scrollController,
  });
  final ScrollController scrollController;
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  RxString onFocus = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      child: Column(
        children: [
          siteMap(),
          toTop(),
          Container(
            alignment: Alignment.center,
            // color: Colors.grey[400],
            width: double.infinity,
            child: socialNetworkAndLegal(),
          ),
        ],
      ),
    );
  }

  Widget siteMap() {
    return Padding(
      padding: EdgeInsets.only(top: 50, bottom: 20),
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
              (e) => site(e),
            )
            .toList(),
      ),
    );
  }

  Widget site(String name) {
    return Row(
      children: [
        Obx(() => MouseRegion(
              onEnter: (event) {
                onFocus.value = name;
              },
              onExit: (event) {
                onFocus.value = '';
              },
              child: InkWell(
                onTap: () {
                  paging(name == PageName.home ? '' : name);
                },
                child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 800),
                    curve: Curves.ease,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: onFocus.value == name
                            ? Colors.teal
                            : Colors.grey[600]),
                    child: FittedBox(
                      child: Text(
                        name.capitalize,
                      ),
                    )),
              ),
            )),
        Text(
          '  |  ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget toTop() {
    return IconButton(
      onPressed: () {
        widget.scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 900),
          curve: Curves.ease,
        );
      },
      padding: EdgeInsets.all(0),
      tooltip: 'Go to top',
      icon: Icon(
        Icons.arrow_circle_up_outlined,
        size: 36,
      ),
      color: Colors.teal,
    );
  }

  Widget legal() {
    return FittedBox(
      child: Text(
        '© 2020 Nguyen Hai Dang • +84 788 708 753 • Can Tho - Viet Nam',
        style: TextStyle(color: Colors.grey[700]),
      ),
    );
  }

  Widget social() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            launch('https://www.facebook.com/DannyNguyenvn');
          },
          child: Image.asset(
            'assets/images/facer.png',
            width: 30,
            height: 30,
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () {
            launch('https://www.linkedin.com/in/haidangdev/');
          },
          child: Image.asset(
            'assets/images/linkin.png',
            width: 30,
            height: 30,
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () {
            launch('https://www.instagram.com/dannynguyen7d/');
          },
          child: Image.asset(
            'assets/images/insta.png',
            width: 30,
            height: 30,
          ),
        ),
      ],
    );
  }

  Widget socialNetworkAndLegal() {
    return Container(
      width: 800,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: MediaQuery.of(context).size.width < 800
            ? Column(
                children: [
                  social(),
                  SizedBox(height: 10),
                  legal(),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  legal(),
                  social(),
                ],
              ),
      ),
    );
  }
}
