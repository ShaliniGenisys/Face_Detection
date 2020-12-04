import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/fail/otp_fail.dart';
import 'package:shop_app/screens/fail/sign_in_fail.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart'; // sign in camera
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/otp/components/cam2.dart';
import 'package:shop_app/screens/otp/components/otp_form.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/sign_up/components/cam.dart';
import 'package:shop_app/screens/sign_up_success/sign_up_success_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'screens/otp/components/cam.dart';
import 'screens/sign_up/sign_up_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case "/splash":
        if (true) {
          return MaterialPageRoute(
            builder: (_) => SplashScreen(),
          );
        }
        return _errorRoute();
      // return MaterialPageRoute(builder: (_) => SplashScreen());
      // case '/second':
      //   // Validation of correct data type
      //   if (args is String) {
      //     return MaterialPageRoute(
      //       builder: (_) => SecondPage(
      //         data: args,
      //       ),
      //     );
      //   }
      //   // If args is not of the correct type, return an error page.
      //   // You can also throw an exception while in development.
      //   return _errorRoute();
      case "/sign_in":
        if (true) {
          return MaterialPageRoute(
            builder: (_) => SignInScreen(),
          );
        }
        return _errorRoute();
      // return MaterialPageRoute(builder: (_) => SignInScreen());
      case "/login_success":
        if (true) {
          return MaterialPageRoute(
            builder: (_) => LoginSuccessScreen(),
          );
        }
        return _errorRoute();

      case "/otp_failure":
        return MaterialPageRoute(
          builder: (_) => OtpFailureScreen(),
        );
      case "/sign_in_failure":
        return MaterialPageRoute(
          builder: (_) => SignInFailureScreen(),
        );
      case "/sign_up_success":
        if (true) {
          return MaterialPageRoute(
            builder: (_) => SignUpSuccessScreen(),
          );
        }
        return _errorRoute();

      // return MaterialPageRoute(builder: (_) => LoginSuccessScreen());
      case "/sign_up":
        if (true) {
          return MaterialPageRoute(
            builder: (_) => SignUpScreen(),
          );
        }
        return _errorRoute();
      // return MaterialPageRoute(builder: (_) => SignUpScreen());
      // case "/complete_profile":
      //   if (args is CameraDescription) {
      //     return MaterialPageRoute(
      //       builder: (_) => CompleteProfileScreen(
      //         camera: args,
      //       ),
      //     );
      //   }
      //   return _errorRoute();
      // return MaterialPageRoute(builder: (_) => CompleteProfileScreen());
      case "/otp":
        return MaterialPageRoute(builder: (_) {
          ScreenArguments argument = args;
          return OtpScreen(
              entry_type: argument.entry_type,
              bvn: argument.bvn,
              phno: argument.phno);
        });
      // return _errorRoute();
      // return MaterialPageRoute(builder: (_) => OtpScreen());
      case "/cam":
        return MaterialPageRoute(builder: (_) {
          ScreenArguments argument = args;
          return CameraScreen(
              entry_type: argument.entry_type,
              bvn: argument.bvn,
              phno: argument.phno);
        });
      case "/cam2":
        return MaterialPageRoute(builder: (_) {
          ScreenArguments argument = args;
          return FacePage(
              entry_type: argument.entry_type,
              bvn: argument.bvn,
              phno: argument.phno);
        });
      case "/uploadPicture":
        return MaterialPageRoute(builder: (_) {
          ScreenArguments argument = args;
          return UploadPictureScreen(
              entry_type: argument.entry_type,
              bvn: argument.bvn,
              phno: argument.phno);
        });

      // case "/home":
      //   return MaterialPageRoute(builder: (_) {
      //     ScreenArguments argument = args;
      //     return HomeScreen(
      //         entry_type: argument.entry_type,
      //         bvn: argument.bvn,
      //         phno: argument.phno);
      //   });

      // return _errorRoute();
      // return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('FAILED'),
        ),
        body: Center(
          child: Text('UNSUCESSFULL !!'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              (_),
              SplashScreen.routeName,
            );
          },
        ),
      );
    });
  }
}
