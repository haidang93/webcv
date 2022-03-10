import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:webcv/app/modules/Contact/controllers/contact_controller.dart';
import 'package:webcv/common/my_function.dart';
import 'package:webcv/common/widget/drawer.dart';
import 'package:webcv/common/widget/footer.dart';
import 'package:webcv/common/widget/header.dart';

import '../../../../main.dart';

class ContactView extends GetView<ContactController> {
  item() {
    return [
      Flexible(
        child: Column(
          children: [
            myTextField('Your name', controller.name),
            myTextField('Your email', controller.email),
            myTextField('Tilte', controller.title),
            myTextField('Your messages', controller.content),
            Container(
              child: FlatButton(
                minWidth: double.infinity,
                height: 50,
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                onPressed: () async {
                  looseFocus(controller.context);
                  var doc = '${controller.title.text} - ${DateTime.now()}';
                  if (controller.name.text != '' &&
                      controller.email.text != '') {
                    var documentReference = FirebaseFirestore.instance
                        .collection('webMessage')
                        .doc(doc);

                    await FirebaseFirestore.instance
                        .runTransaction((transaction) async {
                      transaction.set(
                        documentReference,
                        {
                          'time': DateTime.now().toString(),
                          'timestamp':
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          'name': controller.name.text,
                          'email': controller.email.text,
                          'title': controller.title.text == ''
                              ? 'NoTitle'
                              : controller.title.text,
                          'content': controller.content.text,
                          'read': false,
                          'doc': doc,
                        },
                      );
                    });
                    controller.name.clear();
                    controller.email.clear();
                    controller.title.clear();
                    controller.content.clear();

                    showDialog(
                        context: controller.context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('Messages sent'),
                            content: Text(
                                'Thankyou for your message. I will reply soon.'),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(controller.context);
                                  },
                                  child: Text('OK'))
                            ],
                          );
                        });
                  } else {
                    showDialog(
                        context: controller.context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(
                                'Name, email and messages can not be empty!'),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(controller.context);
                                  },
                                  child: Text('OK'))
                            ],
                          );
                        });
                  }
                },
                child: Text(
                  'SEND',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 30),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/call.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  FittedBox(
                    child: SelectableText(
                      '+84 788 708 753',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/mail.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  FittedBox(
                    child: SelectableText(
                      'dannynguyen.vnn@gmail.com',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/face.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  FittedBox(
                    child: SelectableText(
                      'facebook.com/DannyNguyenvn/',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/zoom.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  FittedBox(
                    child: SelectableText(
                      'dannynguyen.vnn@gmail.com',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/skype.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  FittedBox(
                    child: SelectableText(
                      'dannynguyen.vnn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  big() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            'Contact me',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        MediaQuery.of(controller.context).size.width < 800
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: item(),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item(),
              ),
      ],
    );
  }

  myTextField(String name, TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, name == 'Your messages' ? 20 : 0, 20,
            name == 'Your messages' ? 20 : 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextField(
          controller: control,
          maxLines: name == 'Your messages' ? 9 : 1,
          style: TextStyle(fontSize: 16),
          textInputAction:
              name == 'Your messages' ? TextInputAction.newline : null,
          // keyboardType: name == 'Your email'
          //     ? TextInputType.emailAddress
          //     : TextInputType.text,
          cursorColor: Colors.black,
          cursorRadius: Radius.circular(30),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              border: InputBorder.none,
              hintText: name,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return GestureDetector(
      onTap: () {
        looseFocus(context);
      },
      child: Scaffold(
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
                padding: EdgeInsets.all(30),
                child: big(),
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
