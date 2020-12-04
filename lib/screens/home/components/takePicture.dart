// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' show join;
// import 'package:path_provider/path_provider.dart';
// import 'package:shop_app/screens/login_success/login_success_screen.dart';

// class TakePictureScreen extends StatefulWidget {
//   final CameraDescription camera;
//   final String entry_type;
//   final String bvn;
//   final String phno;

//   const TakePictureScreen(
//       {Key key,
//       @required this.camera,
//       @required this.entry_type,
//       @required this.bvn,
//       @required this.phno})
//       : super(key: key);

//   @override
//   TakePictureScreenState createState() =>
//       TakePictureScreenState(this.entry_type, this.bvn, this.phno);
// }

// class TakePictureScreenState extends State<TakePictureScreen> {
//   final String entry_type;
//   final String bvn;
//   final String phno;
//   TakePictureScreenState(this.entry_type, this.bvn, this.phno);

//   CameraController _controller;
//   Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // To display the current output from the Camera,
//     // create a CameraController.
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.medium,
//     );

//     // Next, initialize the controller. This returns a Future.
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // App state changed before we got the chance to initialize.
//     if (_controller == null || !_controller.value.isInitialized) {
//       return;
//     }
//     if (state == AppLifecycleState.inactive) {
//       _controller?.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       if (_controller != null) {
//         onNewCameraSelected(_controller.description);
//       }
//     }
//   }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   if (state == AppLifecycleState.resumed) {
//   //     _controller != null
//   //         ? _initializeControllerFuture = _controller.initialize()
//   //         : null; //on pause camera is disposed, so we need to call again "issue is only for android"
//   //   }
//   // }

//   void onNewCameraSelected(CameraDescription cameraDescription) async {
//     if (_controller != null) {
//       await _controller.dispose();
//     }
//     _controller = CameraController(
//       cameraDescription,
//       ResolutionPreset.medium,
//     );

//     // If the controller is updated then update the UI.
//     _controller.addListener(() {
//       if (mounted) setState(() {});
//       if (_controller.value.hasError) {
//         showInSnackBar('Camera error ${_controller.value.errorDescription}');
//       }
//     });

//     try {
//       await _controller.initialize();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//     }

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   void _showCameraException(CameraException e) {
//     logError(e.code, e.description);
//     showInSnackBar('Error: ${e.code}\n${e.description}');
//   }

//   void logError(String code, String message) =>
//       print('Error: $code\nError Message: $message');

// // ########################################################################################
//   int counter = 0;
//   var facePosition = [
//     "Look Straight at the Camera",
//     "Look to the right",
//     "Look to the left",
//     "Look Up",
//     "Look Down"
//   ];
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   void showInSnackBar(String message) {
//     // ignore: deprecated_member_use
//     _scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text(
//         message,
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 20, color: Colors.white),
//       ),
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.black.withOpacity(0.3),
//     ));
//   }

//   String getRandomTask() {
//     var randomTasks = [
//       "Put your right index finger on the \ntip of your nose",
//       "Put your left index finger on the \ntip of your nose",
//       "Put your right hand on the top of \nyour head",
//       "Put your left hand on the top of \nyour head",
//       "Close your right eye",
//       "Close your left eye"
//     ];
//     Random random = new Random();
//     int randomNumber = random.nextInt(randomTasks.length);
//     return randomTasks[randomNumber];
//   }

// // ###########################Text(getRandomTask()##########################################################
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: AppBar(
//             centerTitle: true,
//             backgroundColor: Color(0xFFFF7643),
//             title: entry_type == "sign_in"
//                 ? Text(
//                     "Take a picture",
//                     // getRandomTask(),
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   )
//                 : Text("Take picture in 5 different angles",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white, fontSize: 20))),
//       ),
//       // Wait until the controller is initialized before displaying the
//       // camera preview. Use a FutureBuilder to display a loading spinner
//       // until the controller has finished initializing.
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If the Future is complete, display the preview.

//             return CameraPreview(_controller);
//           } else {
//             // Otherwise, display a loading indicator.
//             if (entry_type == "sign_up") {
//               showInSnackBar("Look Straight into the camera");
//             }
//             return Center(child: CircularProgressIndicator());
//             // return Text("Look Straight Into the Camera");
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.camera_alt),
//         backgroundColor: Color(0xFFFF7643),
//         // Provide an onPressed callback.
//         onPressed: () async {
//           // Take the Picture in a try / catch block. If anything goes wrong,
//           // catch the error.

//           _scaffoldKey.currentState.removeCurrentSnackBar();
//           try {
//             // Ensure that the camera is initialized.
//             await _initializeControllerFuture;

//             // Construct the path where the image should be saved using the
//             // pattern package.

//             var a = await getExternalStorageDirectory();
//             final path = join(
//               // Store the picture in the temp directory.
//               // Find the temp directory using the `path_provider` plugin.
//               (a).path,
//               // a,
//               '${DateTime.now()}.png',
//             );
//             print("------> $a <----------");
//             print("-------> $path <--------");
//             // Attempt to take a picture and log where it's been saved.
//             await _controller.takePicture(path);

//             print(path);
//             print(Image.file(File(path)));

//             List<int> bytes = await File(path).readAsBytes();
//             String img64 = base64Encode(bytes);

//             print(img64);
//             print(bvn);
//             // var bvn = 1000;
//             if (entry_type == "sign_in") {
//               final res = await http.post(
//                 'http://52.172.149.74:5001/verify_face',
//                 headers: <String, String>{
//                   'Content-Type': 'application/json; charset=UTF-8',
//                 },
//                 body: jsonEncode(
//                     <String, String>{'BVN': bvn.toString(), 'Image': img64}),
//               );

//               // if (json.decode(res.body)["message"] ==
//               //     "Face successfully verified.") {
//               Navigator.pushNamed(context, LoginSuccessScreen.routeName,
//                   arguments: widget.camera);
//               // } //#######################################################################
//             } else if (entry_type == "sign_up") {
//               // counter = counter + 1;
//               // showInSnackBar(facePosition[counter]);
//               // if (counter >= 4) {
//               //   counter = 0;

//               final res = await http.post(
//                 'http://52.172.149.74:5001/register',
//                 headers: <String, String>{
//                   'Content-Type': 'application/json; charset=UTF-8',
//                 },
//                 body: jsonEncode(<String, String>{
//                   'BVN': bvn.toString(),
//                   'Name': "",
//                   "Phone_Number": phno,
//                   "Image": img64
//                 }),
//               );
//               print(res.body);
//               // if (json.decode(res.body)["message"] ==
//               //     "Successfully added new profile.") {
//               Navigator.pushNamed(context, LoginSuccessScreen.routeName,
//                   arguments: widget.camera);
//               // }
//               // else {
//               //   // Navigator.push(
//               //   //   context,
//               //   //   MaterialPageRoute(
//               //   //     builder: (context) =>
//               //   //         DisplayPictureScreen(imagePath: path),
//               //   //   ),
//               //   // );
//               //   Navigator.pushNamed(context, '/someFailPage');
//               // }

//               // Navigator.pushNamed(context, LoginSuccessScreen.routeName,
//               //     arguments: widget.camera);
//               // }
//             }

//             // Navigator.pushNamed(context, LoginSuccessScreen.routeName);

//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) => DisplayPictureScreen(imagePath: path),
//             //   ),
//             // );
//           } catch (e) {
//             // If an error occurs, log the error to the console.
//             print(e);
//           }
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

// // A widget that displays the picture taken by the user.
// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Display the Picture')),
//       // The image is stored as a file on the device. Use the `Image.file`
//       // constructor with the given path to display the image.
//       body: Image.file(File(imagePath)),
//     );
//   }
// }
