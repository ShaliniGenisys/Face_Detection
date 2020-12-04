import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/loader.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/otp/components/otp_form.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/sign_up_success/sign_up_success_screen.dart';
import 'dart:io';
import 'dart:convert';
import '../../../constants.dart';
import '../../login_success/login_success_screen.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String firstName;
  String email;
  String bvn;
  String phno;
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildBVNField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhnoField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                // var path = await FlutterTestSelfiecapture.detectLiveliness(
                //     "Click a picture!", " ");

                // final picker = ImagePicker();
                // final pickedFile =
                //     await picker.getImage(source: ImageSource.gallery);
                // var path = pickedFile.path;

                // List<int> bytes = await File(path).readAsBytes();
                // String img64 = base64Encode(bytes);

                // final res = await http.post(
                //   'http://52.172.149.74:5001/register',
                //   headers: <String, String>{
                //     'Content-Type': 'application/json; charset=UTF-8',
                //   },
                //   body: jsonEncode(<String, String>{
                //     'BVN': bvn.toString(),
                //     'Name': firstName.toString(),
                //     "Phone_Number": phno,
                //     "Image": img64
                //   }),
                // );
                Navigator.pushNamed(context, "/uploadPicture",
                    arguments: ScreenArguments(firstName, bvn, phno));
                // Navigator.pushNamed(context, SignUpSuccessScreen.routeName,
                //     arguments: widget.camera);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPhnoField() {
    return TextFormField(
      obscureText: false,
      onSaved: (newValue) => phno = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNullError);
        }
        phno = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone No",
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
      obscureText: false,
      onSaved: (newValue) => bvn = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        bvn = value;
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
