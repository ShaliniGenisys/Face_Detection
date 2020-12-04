import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/otp/components/otp_form.dart';

import 'package:http/http.dart' as http;
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../otp/otp_screen.dart';
import 'package:shop_app/models/sendotp.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String bvn;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<Sendotp> sendotp(String bvnNumber) async {
    final String apiUrl = "http://52.172.149.74:5001/send_otp";

    final response = await http.post(apiUrl, body: {"BVN": bvnNumber});

    if (response.statusCode == 201) {
      final String responseString = response.body;

      return sendotpFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildBVNField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // buildPasswordFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              // GestureDetector(
              //   onTap: () => Navigator.pushNamed(
              //       context, ForgotPasswordScreen.routeName),
              //   child: Text(
              //     "Forgot Password",
              //     style: TextStyle(decoration: TextDecoration.underline),
              //   ),
              // )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                // Navigator.pushNamed(context, OtpScreen.routeName,
                //     arguments: widget.camera);

                // var path = FlutterTestSelfiecapture.detectLiveliness(
                //     "Live Verification Test", "msgBlinkEye");
                // ###
                // Sending a POST request
                print("$bvn");

                var res = await http.post(
                  'http://52.172.149.74:5001/send_otp',
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'BVN': bvn,
                  }),
                );
                print(res.body);

                // ###
                Navigator.pushNamed(context, OtpScreen.routeName,
                    arguments: ScreenArguments("sign_in", bvn, ""));
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: false,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPhoneError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPhoneError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone No.",
        hintText: "Enter your Phone Number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildBVNField() {
    return TextFormField(
      // keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => bvn = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kUUIDNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "BVN No.",
        hintText: "Enter your BVN Number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}

// class ScreenArguments {
//   final CameraDescription camera;
//   final String entry_type;
//   final String bvn;

//   ScreenArguments(this.camera, this.entry_type, this.bvn);
// }
