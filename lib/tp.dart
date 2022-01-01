import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/utils.dart';
import 'package:insta_reels/services/download_controller.dart';
import 'package:insta_reels/services/reel_download.dart';
import 'package:insta_reels/tp1.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isTapped = false;
  FlutterInsta flutterInsta = FlutterInsta();
  bool downloading = false;
  DownloadController downloadController = Get.put(DownloadController());
  TextEditingController urlController = TextEditingController();

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  void _requestDownload(String link) async {
    print(link);
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      final taskId = await FlutterDownloader.enqueue(
        url: link,
        savedDir: externalDir!.path,
        showNotification: true,
        // show download progress in status bar (for Android)
        openFileFromNotification: true,
        // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true,
        fileName: 'Yash.mp4',
      );
    } else {
      print('Permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff13031C),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Yash\'s Appzz',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    color: Color(0xff13031C),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Reels Downloader',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: size.height * .28,
                    right: size.width * .15,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.yellow, Colors.red])),
                    ),
                  ),
                  Positioned(
                    top: size.height * .15,
                    right: -size.width * .15,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.purple, Colors.pink])),
                    ),
                  ),
                  Positioned(
                    bottom: size.height * .21,
                    left: -size.width * .1,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.purple, Colors.blue])),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -size.width * .1,
                    child: Container(
                      height: 210,
                      width: 210,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.green, Colors.white])),
                    ),
                  ),
                  Positioned(
                    top: size.height * .25,
                    left: size.width * .02,
                    child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.lightGreen, Colors.lightGreen])),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: size.height * .2),
                        Expanded(
                          flex: 7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                              child: SizedBox(
                                width: size.width * .9,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: size.height * .16,
                                      width: size.height * .16,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'images/insta_logo.png'),
                                            fit: BoxFit.fitHeight),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * .05,
                                    ),
                                    Text(
                                      'Paste The Link',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                    SizedBox(height: size.height * .05),
                                    component(
                                      Icons.paste,
                                      'Link',
                                      false,
                                      false,
                                    ),
                                    SizedBox(height: size.height * .05),
                                    Obx(
                                      () => downloadController.processing.value
                                          ? Container(
                                              width: 50,
                                              height: 50,
                                              color: Colors.transparent,
                                              child: LoadingWidget(),
                                            )
                                          : InkWell(
                                              highlightColor:
                                                  Colors.transparent,
                                              splashColor: Colors.transparent,
                                              onHighlightChanged: (value) {
                                                setState(() {
                                                  isTapped = value;
                                                });
                                              },
                                              onTap: () async {
                                                print("pressed");
                                                print(urlController.text);
                                                downloadController.downloadReal(
                                                    urlController.text);
                                                urlController.clear();
                                              },
                                              child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                height: isTapped ? 55 : 60,
                                                width: isTapped ? 160 : 180,
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(.9),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                      blurRadius: 30,
                                                      offset: Offset(3, 7),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Download',
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .3,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget component(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.white.withOpacity(.9),
        ),
        controller: urlController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.8),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
