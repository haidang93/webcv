import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webcv/app/modules/news_preview/controllers/news_preview_controller.dart';
import 'package:photo_view/photo_view.dart';

class NewsPhotoView extends StatefulWidget {
  NewsPhotoView({Key key, this.url, this.tagHero}) : super(key: key);
  final String url;
  final String tagHero;
  final controller = Get.find<NewsPreviewController>();
  @override
  State<StatefulWidget> createState() => _NewsPhotoView();
}

class _NewsPhotoView extends State<NewsPhotoView> {
  PhotoViewScaleStateController scaleStateController;
  bool full = true;
  @override
  void initState() {
    super.initState();
    scaleStateController = PhotoViewScaleStateController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: Dialog(
        insetPadding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  full = !full;
                });
              },
              // onVerticalDragStart: (drag) {
              //   setState(() {
              //     full = !full;
              //   });
              // },
              child: ClipRRect(
                child: Hero(
                  tag: widget.tagHero,
                  child: PhotoView(
                    scaleStateController: scaleStateController,
                    // backgroundDecoration: BoxDecoration(
                    //   // color: Colors.red
                    // ),
                    imageProvider: NetworkImage(widget.url),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 1.8,
                    initialScale: PhotoViewComputedScale.contained,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: full,
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close_sharp),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            // widget.controller.attachmentDownload(widget.url);
                          },
                          icon: Icon(Icons.download_sharp),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            // widget.controller.shareImage(widget.url);
                          },
                          icon: Icon(Icons.share_sharp),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert_sharp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
