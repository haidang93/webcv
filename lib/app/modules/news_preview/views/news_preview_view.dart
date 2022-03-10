import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_render.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:webcv/common/const.dart';
import 'package:html/dom.dart' as domHtml;
import 'package:url_launcher/url_launcher.dart';

import '../controllers/news_preview_controller.dart';
import 'news_photo_view.dart';

class NewsPreviewView extends GetView<NewsPreviewController> {
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(),
      ),
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: Text('News',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          centerTitle: true,
        ),
        body: Obx(
          () => controller.inited.value ? main() : loading(),
        ),
      ),
    );
  }

  Widget main() {
    return Obx(() => controller.news.value == null ? noContent() : content());
  }

  Widget content() {
    return Column(
      children: [
        Expanded(
            child: ListView(
          // padding: EdgeInsets.fromLTRB(17, 15, 17, Get.mediaQuery.padding.bottom),
          padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 20),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15.0, right: 15),
              child: Text(
                controller.news.value.draft.title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: controller.isPhone ? 20 : 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15.0, right: 15),
              child: Text(
                formatDate(controller.news.value.createdAt) ??
                    '00:00, 01/01/1970',
                style: TextStyle(fontSize: controller.isPhone ? 14 : 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15.0, right: 15),
              child: Text(
                controller.news.value.draft.preview ?? '',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: !controller.isPhone ? 20 : 16,
                ),
              ),
            ),
            (controller.news.value.draft.content.contains('img') &&
                    controller.news.value.draft.content
                        .contains(RegExp(r'(\<\w*)((\s\/\>)|(.*\<\/\w*\>))')))
                ? Html(
                    data: r'''
                                <html lang="en">
                                <head>
                                 <meta name="viewport" content="width= device-width , initial-scale=1">
                                <style> body:not(img) {margin: 0; padding: 0;} img { width:auto; max-width: 100%;} </style> </head>
                                 <body>''' +
                        (controller.news.value.draft.content ?? '') +
                        '''
                                 </body>
                                </html>''',
                    // onImageTap: (String url) {
                    //   print(url);
                    //   Get.to( NewsPhotoView(url: url));
                    // },
                    shrinkWrap: true,

                    style: {
                      "*": Style(
                          padding: EdgeInsets.zero, margin: EdgeInsets.zero),
                      "body": Style(
                        color: Color(0xFF303030),
                        fontSize:
                            !controller.isPhone ? FontSize(20) : FontSize(16),
                        textAlign: TextAlign.justify,
                      ),
                      "figure": Style(
                          padding: EdgeInsets.zero, margin: EdgeInsets.zero),
                      "img": Style(
                          padding: EdgeInsets.zero, margin: EdgeInsets.zero),
                      "h1":
                          Style(padding: EdgeInsets.only(left: 15, right: 15)),
                      "h2":
                          Style(padding: EdgeInsets.only(left: 15, right: 15)),
                      "h3":
                          Style(padding: EdgeInsets.only(left: 15, right: 15)),
                      "h4":
                          Style(padding: EdgeInsets.only(left: 15, right: 15)),
                      "h5":
                          Style(padding: EdgeInsets.only(left: 15, right: 15)),
                      "h6":
                          Style(padding: EdgeInsets.only(left: 15, right: 15)),
                      // "p": Style(padding: EdgeInsets.zero, margin: EdgeInsets.zero),
                      "li": Style(padding: EdgeInsets.only(right: 15)),
                      "ul": Style(padding: EdgeInsets.only(right: 15)),
                      "ol": Style(padding: EdgeInsets.only(right: 15)),
                      "blockquote":
                          Style(padding: EdgeInsets.only(left: 15, right: 15)),
                      "a": Style(padding: EdgeInsets.only(left: 15, right: 15))
                    },
                    customImageRenders: {
                      (attr, _) => attr["src"] != null: networkImageRender(),
                    },
                    customRender: {
                      "p": (context, child, attributes, element) {
                        if (element.innerHtml.contains('img')) {
                          var html = '';
                          element.nodes.forEach((e) {
                            if (e is domHtml.Text) {
                              html += '<div>' + e.text + '</div>';
                            }
                            if (e is domHtml.Element) {
                              html += e.outerHtml;
                            }
                          });
                          print(html);
                          // var i = f.
                          return Html(
                            shrinkWrap: true,
                            data: r'''<body>''' + html + '''</body>''',
                            customImageRenders: {
                              (attr, _) => attr["src"] != null:
                                  networkImageRender(),
                            },
                            onLinkTap: (url) async {
                              if (await canLaunch(url)) {
                                launch(url);
                              }
                            },
                            style: {
                              "img": Style(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero),
                              "*": Style(
                                  fontSize: !controller.isPhone
                                      ? FontSize(20)
                                      : FontSize(16),
                                  textAlign: TextAlign.justify,
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.zero
                                  // padding: EdgeInsets.only(left: 15, right: 15)
                                  ),
                              "div": Style(
                                padding: EdgeInsets.only(right: 15, left: 15),
                                fontSize: !controller.isPhone
                                    ? FontSize(20)
                                    : FontSize(16),
                                textAlign: TextAlign.justify,
                              )
                            },
                          );
                        } else {
                          return Html(
                            data: r'''''' + element.outerHtml + '''''',
                            style: {
                              "p": Style(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  fontSize: !controller.isPhone
                                      ? FontSize(20)
                                      : FontSize(16),
                                  textAlign: TextAlign.justify)
                            },
                          );
                        }
                      }
                    },
                    onLinkTap: (url) async {
                      if (await canLaunch(url)) {
                        launch(url);
                      }
                    },
                  )
                : Html(
                    data: r'''
                            <html lang="en">
                            <head>
                             <meta name="viewport" content="width= device-width , initial-scale=1">
                            <style> body:not(img) {margin: 0; padding: 0;} img { width:auto; max-width: 100%;} </style> </head>
                             <body>''' +
                        (controller.news.value.draft.content ?? '') +
                        '''
                             </body>
                            </html>''',
                    shrinkWrap: true,
                    style: {
                      "body": Style(
                          color: Color(0xFF303030),
                          fontSize:
                              !controller.isPhone ? FontSize(20) : FontSize(16),
                          textAlign: TextAlign.justify,
                          padding: EdgeInsets.only(left: 11, right: 11),
                          alignment: Alignment.topLeft
                          // margin: EdgeInsets.zero
                          ),
                    },
                  ),
          ],
        )),
      ],
    );
  }

  Widget noContent() {
    return Center(
      child: Obx(() => Text(controller.text.value)),
    );
  }

  Widget loading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/images/bamboo_loading.zip', height: 120),
          Text('Loading...'),
          SizedBox(height: 200)
        ],
      ),
    );
  }

  ImageRender networkImageRender({
    Map<String, String> headers,
    double width,
    double height,
    Widget Function(String) altWidget,
  }) =>
      (context, attributes, element) {
        Completer<Size> completer = Completer();
        precacheImage(
          NetworkImage(
            attributes["src"],
            headers: headers,
          ),
          context.buildContext,
          onError: (exception, StackTrace stackTrace) {
            context.parser.onImageError?.call(exception, stackTrace);
          },
        );
        Image image = Image.network(attributes["src"],
            frameBuilder: (ctx, child, frame, _) {
          if (frame == null) {
            if (!completer.isCompleted) {
              completer.completeError("error");
            }
            return child;
          } else {
            return child;
          }
        });
        image.image.resolve(ImageConfiguration()).addListener(
              ImageStreamListener((ImageInfo image, bool synchronousCall) {
                var myImage = image.image;
                Size size =
                    Size(myImage.width.toDouble(), myImage.height.toDouble());
                if (!completer.isCompleted) {
                  completer.complete(size);
                }
              }, onError: (object, stacktrace) {
                if (!completer.isCompleted) {
                  completer.completeError(object);
                }
              }),
            );

        return FutureBuilder<Size>(
            future: completer.future,
            builder: (BuildContext buildContext, AsyncSnapshot<Size> snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
                  child: InkWell(
                    onTap: () {
                      Get.to(NewsPhotoView(
                        url: attributes["src"],
                        tagHero: attributes["src"],
                      ));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Hero(
                            tag: attributes["src"],
                            child: Image.network(
                              attributes["src"] ?? "about:blank",
                              headers: headers,
                              // width: snapshot.data.width ?? width,
                              // height: height,
                              semanticLabel: attributes["longdesc"] ?? "",
                              fit: BoxFit.fitWidth,
                              frameBuilder: (ctx, child, frame, _) {
                                if (frame == null) {
                                  return altWidget.call(attributes["alt"]) ??
                                      Text(attributes["alt"] ?? "",
                                          style: context.style
                                              .generateTextStyle());
                                }
                                return child;
                              },
                              errorBuilder: (c, o, s) {
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Cannot load image!!!'));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
      };

  String formatDate(String date) {
    if (date == null) return 'no date';
    final d = DateTime.parse(date).toLocal();
    String day = d.day < 10 ? '0' + '${d.day}' : '${d.day}';
    String month = d.month < 10 ? '0' + '${d.month}' : '${d.month}';
    int hourInt = d.hour > 12 ? d.hour - 12 : d.hour;
    String hour = hourInt < 10 ? '0' + '$hourInt' : '$hourInt';
    String minute = d.minute < 10 ? '0' + '${d.minute}' : '${d.minute}';
    String timeSuffix = d.hour > 12 ? 'pm' : 'am';
    // return '$day/$month/${d.year} $hour:$minute $timeSuffix';
    return '$hour:$minute $day/$month/${d.year} ';
  }
}
