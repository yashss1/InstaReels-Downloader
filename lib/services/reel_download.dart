// import 'package:flutter_insta/flutter_insta.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
//
// class ReelDownloader {
//   FlutterInsta flutterInsta = FlutterInsta();
//
//   void download(String text) async {
//     var myvideourl = await flutterInsta.downloadReels(text);
//
//     await FlutterDownloader.enqueue(
//       url: '$myvideourl',
//       savedDir: '/Download',
//       showNotification: true,
//       // show download progress in status bar (for Android)
//       openFileFromNotification:
//           true, // click on notification to open downloaded file (for Android)
//     ).whenComplete(() {
//       setState(() {
//         downloading = false; // set to false to stop Progress indicator
//       });
//     });
//   }
// }
