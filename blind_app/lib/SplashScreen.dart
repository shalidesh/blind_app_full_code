import 'package:bindappp/OtherScreens(Testing)/home3.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:bindappp/OtherScreens(Testing)/home.dart';
import 'package:bindappp/OtherScreens(Testing)/home2.dart';

import 'SplashScreenUpdate.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

 @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Logo.jpg', width: 300),
            const SizedBox(height: 20),
            const Text('Vision Mate',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            
              
          ],
        ),
      ),
      backgroundColor: Colors.red,
      nextScreen: LandingPage(),
      splashIconSize: 500,
      duration: 5000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 4),
    );
  }

  //  @override
  // Widget build(BuildContext context) {
  //   return Stack(
  //     alignment: Alignment.bottomCenter,
  //     children: [
  //       AnimatedSplashScreen(
  //         splash: Lottie.asset('assets/animation_llki0mq1.json'),
  //         backgroundColor: Colors.red,
  //         // nextScreen: SpeechScreen(),
  //         nextScreen: const Home(),
  //         splashIconSize: 500,
  //         duration: 5000,
  //         splashTransition: SplashTransition.fadeTransition,
  //         pageTransitionType: PageTransitionType.leftToRightWithFade,
  //         animationDuration: const Duration(seconds: 4),
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.only(top: 16.0, bottom:250.0),
  //         child: Text("I'm Guid You", style: TextStyle(fontSize: 50,fontFamily: 'Roboto',decoration: TextDecoration.none, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold)),
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.only(top: 16.0, bottom:230.0),
  //         child: Text('Let us give the best Assistant', style: TextStyle(fontSize:25,fontFamily: 'Roboto',decoration: TextDecoration.none, color: Color.fromARGB(255, 8, 248, 88), fontWeight: FontWeight.bold)),
  //       ),
  //     ],
  //   );
  // }

}

