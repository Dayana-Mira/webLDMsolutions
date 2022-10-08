import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:web_ldmsolutions/Camera.dart';
import 'homepage.dart';

void main() async{
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera,));
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LDM Solutions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Barlow',
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 70,
                  color: Colors.green[900],
                  fontFamily: 'DMSerifDisplay'),
              headline2: TextStyle(
                  fontSize: 55,
                  color: Colors.green[900],
                  fontFamily: 'DMSerifDisplay'),
              headline3: TextStyle(
                  fontSize: 40,
                  color: Colors.green[900],
                  fontFamily: 'DMSerifDisplay'),
              subtitle1: TextStyle(fontSize: 30, color: Colors.black),
              subtitle2: TextStyle(fontSize: 20, color: Colors.green[900]),
              bodyText1:
              TextStyle(fontSize: 20, color: Colors.green[900], height: 1.25),
              bodyText2:
              TextStyle(fontSize: 18, color: Colors.black, height: 1.25),
              caption: TextStyle(fontSize: 17, color: Colors.black, height: 1.25),
              button: TextStyle(fontSize: 17, color: Color(0xff1e1e24)))),
      home: HomePage(camera: camera), //add the homepage to the main application
      );


  }
}