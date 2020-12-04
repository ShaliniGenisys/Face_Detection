import 'package:flutter/material.dart';
import 'route_generator.dart';
import 'screens/splash/splash_screen.dart';
import 'theme.dart';

// Future<void> main() async {
//   // Ensure that plugin services are initialized so that `availableCameras()`
//   // can be called before `runApp()`
//   WidgetsFlutterBinding.ensureInitialized();

//   // Obtain a list of the available cameras on the device.
//   final cameras = await availableCameras();

//   // Get a specific camera from the list of available cameras.
//   final firstCamera = cameras[1];

//   runApp(MyApp(camera: firstCamera));
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        // initialRoute: SplashScreen.routeName,
        // routes: routes,
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
