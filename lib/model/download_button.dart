// import 'package:flutter/material.dart';
// import 'package:insta_reels/services/reel_download.dart';
//
// class DownloadButton extends StatefulWidget {
//   const DownloadButton({Key? key}) : super(key: key);
//
//   @override
//   State<DownloadButton> createState() => _DownloadButtonState();
// }
//
// class _DownloadButtonState extends State<DownloadButton> {
//   bool isTapped = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       highlightColor: Colors.transparent,
//       splashColor: Colors.transparent,
//       onHighlightChanged: (value) {
//         setState(() {
//           isTapped = value;
//         });
//       },
//       onTap: () {},
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.fastLinearToSlowEaseIn,
//         height: isTapped ? 55 : 60,
//         width: isTapped ? 160 : 180,
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(.9),
//           borderRadius: BorderRadius.circular(40),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.8),
//               blurRadius: 30,
//               offset: Offset(3, 7),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             'Download',
//             style: TextStyle(
//               color: Colors.black.withOpacity(0.7),
//               fontWeight: FontWeight.w500,
//               fontSize: 19,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
