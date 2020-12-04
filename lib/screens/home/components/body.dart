// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:shop_app/screens/login_success/login_success_screen.dart';

// class CameraScreen extends StatefulWidget {
//   final String data; // sign_up sign_in
//   CameraScreen(this.data);

//   @override
//   CameraScreenState createState() => CameraScreenState(this.data);
// }

// class CameraScreenState extends State<CameraScreen> {
//   File _image;
//   String _imagechecker;

//   final String data; // sign_up sign_in
//   CameraScreenState(this.data);

//   final GlobalKey<ScaffoldState> _scaffoldstate =
//       new GlobalKey<ScaffoldState>();

//   Future getImage() async {
//     var image = await ImagePicker.pickImage(
//         source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
//     setState(() {
//       _image = image;
//       _imagechecker = "1";
//       print("image ----> $_image");
//     });
//     sleep(const Duration(seconds: 1));

//     if (this.data == "sign_up") {
//       File _image2, _image3, _image4, _image5;

//       var image2 = await ImagePicker.pickImage(
//           source: ImageSource.camera,
//           preferredCameraDevice: CameraDevice.front);
//       setState(() {
//         _image2 = image2;
//         _imagechecker = "2";
//         print("image ----> $_image");
//       });

//       sleep(const Duration(seconds: 1));
//       var image3 = await ImagePicker.pickImage(
//           source: ImageSource.camera,
//           preferredCameraDevice: CameraDevice.front);
//       setState(() {
//         _image3 = image3;
//         _imagechecker = "3";
//         print("image ----> $_image");
//       });

//       sleep(const Duration(seconds: 1));
//       var image4 = await ImagePicker.pickImage(
//           source: ImageSource.camera,
//           preferredCameraDevice: CameraDevice.front);
//       setState(() {
//         _image4 = image4;
//         _imagechecker = "4";
//         print("image ----> $_image");
//       });
//       sleep(const Duration(seconds: 1));
//       var image5 = await ImagePicker.pickImage(
//           source: ImageSource.camera,
//           preferredCameraDevice: CameraDevice.front);
//       setState(() {
//         _image5 = image5;
//         _imagechecker = "5";
//         print("image ----> $_image");
//       });

//       // TO-DO store images somehow @nikhil
//       // TO-DO logic for api
//       _uploadFile(image);
//     } else {
//       // TO-DO logic for api
//       _uploadFile(image);
//     }

//     // Navigator.pushNamed(context, SplashScreen.routeName);
//   }

//   // Methode for file upload
//   void _uploadFile(filePath) async {
//     // Get base file name
//     String fileName = basename(filePath.path);
//     print("File base name: $fileName");

//     try {
//       // FormData formData =
//       //     new FormData.from({"file": new UploadFileInfo(filePath, fileName)});
//       FormData formData = FormData.fromMap({
//         "file": await MultipartFile.fromFile(filePath.path, filename: fileName),
//       });

//       Response response =
//           await Dio().post("http://192.168.0.144/saveFile.php", data: formData);
//       print("File upload response: $response");

//       // Show the incoming message in snakbar
//       _showSnakBarMsg(response.data['message']);
//     } catch (e) {
//       print("Exception Caught: $e");
//     }
//   }

//   // Method for showing snak bar message
//   void _showSnakBarMsg(String msg) {
//     _scaffoldstate.currentState
//         .showSnackBar(new SnackBar(content: new Text(msg)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     var listOfTasks = [];
//     if (this.data == "sign_in") {
//       var listOfTasks = [
//         "Place your right finger on your nose",
//         "Place your left finger on your nose",
//         "Place your right hand on top of your head",
//         "Place your left hand on top of your head",
//         "Close your left eye",
//         "Close your right eye"
//       ];

//       Random random = new Random();
//       int randomTaskIndex = random.nextInt(listOfTasks.length);
//       var randomTask = listOfTasks[randomTaskIndex];
//       return new MaterialApp(
//         title: 'Face Recognition',
//         home: new Scaffold(
//           key: _scaffoldstate,
//           body: Padding(
//             padding: EdgeInsets.only(
//                 left: 15, right: 15, bottom: _image == null ? 0 : 60),
//             child: new Center(
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Color(0xFFFF7643)),
//                 ),
//                 child: _image == null
//                     ? new Text(
//                         '$randomTask',
//                         style: TextStyle(fontSize: 25),
//                         textAlign: TextAlign.center,
//                       )
//                     : new Image.file(_image),
//                 onPressed: () {
//                   // api logic for azure verification
//                   // api logic for gen-face-rec
//                   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
//                 },
//               ),
//             ),
//           ),
//           floatingActionButton: Padding(
//             padding: EdgeInsets.only(bottom: _image == null ? 60 : 40),
//             child: Container(
//               height: 100,
//               width: 100,
//               child: FittedBox(
//                 child: new FloatingActionButton(
//                     onPressed: getImage,
//                     elevation: 0,
//                     tooltip: 'Pick Image',
//                     child: _image == null
//                         ? new Icon(Icons.add_a_photo_outlined)
//                         : new Text(
//                             'Continue',
//                             style: TextStyle(fontSize: 10),
//                           ),
//                     // label: _image == null ? null : new Text('Continue'),
//                     backgroundColor: Color(0xFFFF7643)),
//               ),
//             ),
//           ),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerDocked,
//         ),
//       );
//     } else {
//       // ELSE !!!!!!!!!! SIGN-UP PART
//       var listOfTasks = {
//         // "1": "Look straight at the Camera",
//         "1": "Look to the right",
//         "2": "Look to the left",
//         "3": "Look Up",
//         "4": "Look down",
//         "5": "Continue"
//       };
//       // Random random = new Random();
//       // int randomTaskIndex = random.nextInt(listOfTasks.length);
//       // var counter = 0;
//       var task = listOfTasks[_imagechecker];
//       return new MaterialApp(
//         title: 'Face Recognition',
//         home: new Scaffold(
//           key: _scaffoldstate,
//           body: Padding(
//             padding: EdgeInsets.only(
//                 left: 15, right: 15, bottom: _image == null ? 30 : 60),
//             child: new Center(
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(Color(0xFFFF7643)),
//                 ),
//                 child: _image == null
//                     ? new Text(
//                         "Look straight at the camera",
//                         style: TextStyle(fontSize: 30),
//                         textAlign: TextAlign.center,
//                       )
//                     : new Text(
//                         task,
//                         style: TextStyle(fontSize: 30),
//                         textAlign: TextAlign.center,
//                       ),
//                 onPressed: () {
//                   // api logic for azure verification
//                   // api logic for gen-face-rec
//                   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
//                 },
//               ),
//             ),
//           ),
//           floatingActionButton: Padding(
//             padding: EdgeInsets.only(bottom: _image == null ? 60 : 40),
//             child: Container(
//               height: 100,
//               width: 100,
//               child: FittedBox(
//                 child: new FloatingActionButton(
//                     onPressed: getImage,
//                     elevation: 0,
//                     tooltip: 'Pick Image',
//                     child: new Icon(Icons.add_a_photo_outlined),

//                     // label: _image == null ? null : new Text('Continue'),
//                     backgroundColor:
//                         _image == null ? Color(0xFFFF7643) : Colors.white),
//               ),
//             ),
//           ),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerDocked,
//         ),
//       );
//     }
//   }
// }

// // floatingActionButton: Container(
// //         height: 100.0,
// //         width: 100.0,
// //         child: FittedBox(
// //           child: FloatingActionButton(onPressed: () {}),
// //         ),
// //       ),
