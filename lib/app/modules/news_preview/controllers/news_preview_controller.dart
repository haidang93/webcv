import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webcv/app/data/models/news_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:webcv/common/network.dart';
import 'package:webcv/main.dart';

class NewsPreviewController extends GetxController {
  // final provider = Provider();
  BuildContext context;
  var news = NewsDetail().obs;
  RxBool inited = false.obs;
  RxString text = "Không có nội dung".obs;
  bool isPhone = true;

  @override
  void onInit() async {
    // isPhone = MediaQuery.of(context).size.width < 800;
    news.value = null;
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    if (newsType == NewsType.CEO) {
      news.value = await getCeoMsg(id: newsId);
    }

    if (newsType == NewsType.NEWS) {
      news.value = await getNewsDetail(id: newsId);
    }

    if ((news.value?.draft?.content ?? '').isEmpty) {
      news.value = null;
    }

    inited.value = true;
  }

  @override
  void onClose() {}

  Future<NewsDetail> getNewsDetail({String id}) async {
    Uri url = Uri.parse(
        'https://new-api.bambooairways.com/public-api/v1/news/detail/$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(res.body);
      if (data["content"] == null) return null;
      return NewsDetail.fromJson(data['content']);
    }
    text.value = 'Network error';

    return null;
  }

  Future<NewsDetail> getCeoMsg({String id}) async {
    Uri url = Uri.parse(
        'https://new-api.bambooairways.com/public-api/v1/news/ceomsg/detail/$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(res.body);
      if (data["content"] == null) return null;
      return NewsDetail.fromJson(data['content']);
    }
    text.value = 'Network error';

    return null;
  }
}

class Provider extends Network {}

bool showingDialog = false;
Future<void> cautionDialog(String content,
    {bool center = true, String title = 'Caution!'}) async {
  if (!showingDialog) {
    showingDialog = true;
    await Get.dialog(Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              content,
              textAlign: center ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FlatButton(
              minWidth: double.infinity,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: primaryColor, //blueColor,
              colorBrightness: Brightness.dark,
              onPressed: Get.back,
              child: Text('OK'),
            ),
          ),
        ],
      ),
    ));
    showingDialog = false;
  }
}

const primaryColor = Color.fromRGBO(80, 147, 68, 1);
