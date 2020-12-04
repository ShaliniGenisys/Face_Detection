import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:selfie_ocr_mtpl/selfie_ocr_mtpl.dart';
import 'package:shop_app/components/loader.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';

import 'package:image/image.dart' as Im;
import 'dart:math' as Math;

class CameraScreen extends StatefulWidget {
  final String entry_type;
  final String bvn;
  final String phno;
  const CameraScreen(
      {Key key,
      @required this.entry_type,
      @required this.bvn,
      @required this.phno})
      : super(key: key);
  @override
  _CameraScreenState createState() => _CameraScreenState(bvn);
}

class _CameraScreenState extends State<CameraScreen> {
  String bvn;
  _CameraScreenState(this.bvn);
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Step 2"),
            ),
            backgroundColor: Colors.white,
            body: Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Center(
                    child: Text(
                  "Take a picture for Face Recognition",
                  style: TextStyle(fontSize: 20),
                ))),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    // var path = await FlutterTestSelfiecapture.detectLiveliness(
                    //     "Live Verification Test",
                    //     "Blink Your Eyes! to take a picture");

                    final picker = ImagePicker(); // HERE !!!!!!!!
                    final pickedFile =
                        await picker.getImage(source: ImageSource.camera);
                    var path = pickedFile.path;

                    // ############
                    print(path);
                    setState(() {
                      loading = true;
                    });

                    File imagePath = File(path);
                    //get temporary directory
                    final tempDir = await getExternalStorageDirectory();
                    int rand = new Math.Random().nextInt(10000);
                    //reading jpg image
                    Im.Image image =
                        Im.decodeImage(imagePath.readAsBytesSync());
                    //decreasing the size of image- optional
                    Im.Image smallerImage = Im.copyResize(image, width: 300);
                    //get converting and saving in file
                    File compressedImage = new File(
                        '${tempDir.path}/img_$rand.png')
                      ..writeAsBytesSync(Im.encodePng(smallerImage, level: 8));

                    var pngPath = "${tempDir.path}/img_$rand.png";
                    print(Image.file(File(pngPath)));
                    // ############

                    List<int> bytes = await File(pngPath).readAsBytes();
                    // List<int> bytes = await File(path).readAsBytes();
                    String img64 = base64Encode(bytes);

                    final res = await http.post(
                      'http://52.172.149.74:5001/verify_face',
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'BVN': bvn.toString(),
                        'Image': img64
                      }),
                    );

                    if (json.decode(res.body)["message"] ==
                        "Face successfully verified.") {
                      Navigator.pushNamed(
                        context,
                        LoginSuccessScreen.routeName,
                      );
                    } else {
                      print("Face verify fail");
                      Navigator.pushNamed(context, '/sign_in_failure');
                    }
                  },
                  child: new Icon(Icons.camera_alt_sharp),
                  backgroundColor: Color(0xFFFF7643),
                )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
