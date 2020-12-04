// // import 'package:flutter/material.dart';

// // import '../../../size_config.dart';
// // import 'categories.dart';
// // import 'discount_banner.dart';
// // import 'home_header.dart';
// // import 'popular_product.dart';
// // import 'special_offers.dart';

// // class Body extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             SizedBox(height: getProportionateScreenHeight(20)),
// //             HomeHeader(),
// //             SizedBox(height: getProportionateScreenWidth(10)),
// //             DiscountBanner(),
// //             Categories(),
// //             SpecialOffers(),
// //             SizedBox(height: getProportionateScreenWidth(30)),
// //             PopularProducts(),
// //             SizedBox(height: getProportionateScreenWidth(30)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // ############################################################################

// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:shop_app/screens/login_success/login_success_screen.dart';

// class CameraScreen extends StatefulWidget {
//   @override
//   CameraScreenState createState() => CameraScreenState();
// }

// class CameraScreenState extends State<CameraScreen> {
//   File _image, _image2, _image3, _image4, _image5;
//   final GlobalKey<ScaffoldState> _scaffoldstate =
//       new GlobalKey<ScaffoldState>();

//   Future getImage() async {
//     var image = await ImagePicker.pickImage(
//         source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
//     var image2 = await ImagePicker.pickImage(
//         source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
//     var image3 = await ImagePicker.pickImage(
//         source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
//     var image4 = await ImagePicker.pickImage(
//         source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
//     var image5 = await ImagePicker.pickImage(
//         source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

//     _uploadFile(image);

//     setState(() {
//       _image = image;
//       _image2 = image2;
//       _image3 = image3;
//       _image4 = image4;
//       _image5 = image5;
//       print("image ----> $_image");
//       print("image ----> $_image2");
//       print("image ----> $_image3");
//       print("image ----> $_image4");
//       print("image ----> $_image5");
//     });

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
//     var listOfTasks = [
//       "Place your right finger on your nose",
//       "Place your left finger on your nose",
//       "Place your right hand on top of your head",
//       "Place your left hand on top of your head",
//       "Close your left eye",
//       "Close your right eye"
//     ];
//     Random random = new Random();
//     int randomTaskIndex = random.nextInt(listOfTasks.length);
//     var randomTask = listOfTasks[randomTaskIndex];
//     return new MaterialApp(
//       title: 'Face Recognition',
//       home: new Scaffold(
//         key: _scaffoldstate,
//         body: Padding(
//           padding: EdgeInsets.only(
//               left: 15, right: 15, bottom: _image == null ? 0 : 60),
//           child: new Center(
//             child: ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all<Color>(Color(0xFFFF7643)),
//               ),
//               child: _image == null
//                   ? new Text(
//                       '$randomTask',
//                       style: TextStyle(fontSize: 25),
//                       textAlign: TextAlign.center,
//                     )
//                   : new Image.file(_image),
//               onPressed: () {
//                 // api logic for azure verification
//                 // api logic for gen-face-rec
//                 Navigator.pushNamed(context, LoginSuccessScreen.routeName);
//               },
//             ),
//           ),
//         ),
//         floatingActionButton: Padding(
//           padding: EdgeInsets.only(bottom: _image == null ? 60 : 40),
//           child: Container(
//             height: 100,
//             width: 100,
//             child: FittedBox(
//               child: new FloatingActionButton(
//                   onPressed: getImage,
//                   elevation: 0,
//                   tooltip: 'Pick Image',
//                   child: _image == null
//                       ? new Icon(Icons.add_a_photo_outlined)
//                       : new Text(
//                           'Continue',
//                           style: TextStyle(fontSize: 10),
//                         ),
//                   // label: _image == null ? null : new Text('Continue'),
//                   backgroundColor: Color(0xFFFF7643)),
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }
// }

// // floatingActionButton: Container(
// //         height: 100.0,
// //         width: 100.0,
// //         child: FittedBox(
// //           child: FloatingActionButton(onPressed: () {}),
// //         ),
// //       ),
