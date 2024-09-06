import 'package:bindappp/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'SplashScreenUpdate.dart';


List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "new app",
      home: SplashScreen(),
    );
  }
}

