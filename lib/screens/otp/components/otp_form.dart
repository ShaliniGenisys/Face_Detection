import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/loader.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/models/verifyotp.dart';
import '../../../constants.dart';
import '../../login_success/login_success_screen.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image/image.dart';
import 'cam.dart';

class OtpForm extends StatefulWidget {
  // final String data;
  // OtpForm(this.data);

  final String entry_type;
  final String bvn;
  final String phno;

  const OtpForm(
      {Key key,
      @required this.entry_type,
      @required this.bvn,
      @required this.phno})
      : super(key: key);

  // @override
  // _OtpFormState createState() => _OtpFormState(this.data);
  @override
  _OtpFormState createState() => _OtpFormState(entry_type, bvn, phno);
}

class _OtpFormState extends State<OtpForm> {
  final String entry_type;
  final String bvn;
  final String phno;
  _OtpFormState(this.entry_type, this.bvn, this.phno);

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  String otp = "";
  // void verifyImage() async {
  //   var c = 0;
  // while (await FlutterTestSelfiecapture.detectLiveliness(
  //           "Live Verification Test", "msgBlinkEye") ==
  //       null) {
  //     print("null");
  //     if (FlutterTestSelfiecapture.detectLiveliness(
  //             "Live Verification Test", "msgBlinkEye") !=
  //         null) {
  //       c = 1;
  //     }
  //   }
  //   if (c == 1) {
  //     Navigator.pushNamed(context, HomeScreen.routeName,
  //         arguments: ScreenArguments(widget.camera, entry_type));
  //   }
  // }

  Future<Verifyotp> verifyotp(String bvnNumber, String otp) async {
    final String apiUrl = "http://52.172.149.74:5001/verify_otp";

    final response =
        await http.post(apiUrl, body: {"BVN": bvnNumber, "OTP": otp});

    if (response.statusCode == 201) {
      final String responseString = response.body;

      return verifyotpFromJson(responseString);
    } else {
      return null;
    }
  }

  Verifyotp _verify;

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Loading()
        : Form(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: getProportionateScreenWidth(50),
                      child: TextFormField(
                        autofocus: true,
                        obscureText: true,
                        style: TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) {
                          otp = otp + value;
                          nextField(value, pin2FocusNode);
                        },
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(50),
                      child: TextFormField(
                        focusNode: pin2FocusNode,
                        obscureText: true,
                        style: TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) {
                          otp = otp + value;
                          nextField(value, pin3FocusNode);
                        },
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(50),
                      child: TextFormField(
                        focusNode: pin3FocusNode,
                        obscureText: true,
                        style: TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) {
                          otp = otp + value;
                          nextField(value, pin4FocusNode);
                        },
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(50),
                      child: TextFormField(
                        focusNode: pin4FocusNode,
                        obscureText: true,
                        style: TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) {
                          otp = otp + value;
                          nextField(value, pin5FocusNode);
                        },
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(50),
                      child: TextFormField(
                        focusNode: pin5FocusNode,
                        obscureText: true,
                        style: TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) {
                          otp = otp + value;
                          nextField(value, pin6FocusNode);
                        },
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(50),
                      child: TextFormField(
                        focusNode: pin6FocusNode,
                        obscureText: true,
                        style: TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) {
                          if (value.length == 1) {
                            otp = otp + value;
                            pin6FocusNode.unfocus();
                            // Then you need to check is the code is correct or not
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.15),
                DefaultButton(
                  text: "Continue",
                  press: () async {
                    print("$bvn");
                    print("$otp");

                    final res = await http.post(
                      'http://52.172.149.74:5001/verify_otp',
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body:
                          jsonEncode(<String, String>{'BVN': bvn, 'OTP': otp}),
                    );
                    // var res = "OTP successfully verified.";
                    // json.decode(res.body)["message"] ==
                    // ######
                    if (json.decode(res.body)["message"] ==
                        "OTP successfully verified.") {
                      Navigator.pushNamed(context, "/cam",
                          arguments: ScreenArguments("", bvn, ""));
                    } else {
                      print("otp fail");
                      Navigator.pushNamed(context, '/otp_failure');
                    }
                    //  #######
                  },
                )
              ],
            ),
          );
  }
}

class StringArguments {}

class ScreenArguments {
  final String entry_type;
  final String bvn;
  final String phno;

  ScreenArguments(this.entry_type, this.bvn, this.phno);
}
