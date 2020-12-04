// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// import 'components/body.dart';
// import 'components/takePicture.dart';

// // class HomeScreen extends StatelessWidget {
// //   static String routeName = "/home";

// //   final String data;

// //   HomeScreen({
// //     Key key,
// //     @required this.data,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         // body: Body(),
// //         body: CameraScreen(data));
// //   }
// // }
// class HomeScreen extends StatelessWidget {
//   static String routeName = "/home";

//   final CameraDescription camera;
//   final String entry_type;
//   final String bvn;
//   final String phno;
//   const HomeScreen(
//       {Key key,
//       @required this.camera,
//       @required this.entry_type,
//       @required this.bvn,
//       @required this.phno})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // body: Body(),
//         body: TakePictureScreen(
//             camera: camera, entry_type: entry_type, bvn: bvn, phno: phno));
//   }
// }
