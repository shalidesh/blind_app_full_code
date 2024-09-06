import 'package:bindappp/ColorDetector.dart';
import 'package:bindappp/Navigation.dart';
import 'package:bindappp/SuperMarkets.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:bindappp/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:async';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:image_picker/image_picker.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  late stt.SpeechToText _speech;
  bool _isListening = false;
  FlutterTts ftts = FlutterTts();

  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  String instruction_text="";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ftts.setSpeechRate(0.5); 
      var result1 = await ftts.speak(
          "hi,i am Alexa.Here are the brief instructions for using the app.Double tap the screen and say “navigation” to access the indoor navigation function.Double tap the screen and say “market” to access the super market object detection function.Double tap the screen and say “detection” to access the dress colour detection and recommendation function.");
      if (result1 == 1) {
        // Speaking
      } else {
        // Not speaking
      }
      // _listen();
    });
    
  }


    void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
              print('User said: ${val.recognizedWords}');
              // Check if the recognized words match the correct sentence
              // if (val.recognizedWords.toLowerCase() == "navigation") {
              //   // Stop listening and perform any actions you want
              //    Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Navigation()),
              //       );
              //     setState(() => _isListening = false);
              //     _speech.stop();
              //   // ...
              // }
              if (val.recognizedWords.toLowerCase() == "market") {
                // Stop listening and perform any actions you want
                 Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SuperMarket()),
                    );
                  setState(() => _isListening = false);
                  _speech.stop();
                // ...
              }
              else if (val.recognizedWords.toLowerCase() == "detection") {
                // Stop listening and perform any actions you want
                 Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ColorDetector()),
                    );
                  setState(() => _isListening = false);
                  _speech.stop();
                // ...
              }
               else {
                
                  setState(() => _isListening = false);
                  _speech.stop();
                // ...
              }
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.alphaBlend(Colors.white10, Colors.black38),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 50.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: GestureDetector(
        onDoubleTap: _listen,
        child: Column(
         
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      
          const SizedBox(
            height: 150,
          ),
          
            MaterialButton(
              onPressed: () async {
                
               
              },
              child: Container(
                margin:const EdgeInsets.only(left: 0),
                height: 100,
                width: 350,
                 decoration:const BoxDecoration(
                   color: Color(0xff01ACC2),
                   borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(40),
                   bottomRight: Radius.circular(40),
                   topRight: Radius.circular(40),
                    ),
                  ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      height: 110,
                      width: 110,
                     
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/image1.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
            
                    Container(
                      height: 150,
                      width: 140,
                      
                      alignment: Alignment.center,
                      child: const Text(
                        'Navigation Guide',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ),
                  ]
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
      
            MaterialButton(
               onPressed: () async {
                
              },
              child: Container(
                height: 100,
                width: 350,
                margin: EdgeInsets.only(left: 0),
                 decoration:const BoxDecoration(
                   color: Color(0xff01ACC2),
                   borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(40),
                   bottomRight: Radius.circular(40),
                   topRight: Radius.circular(40),
                    ),
                  ),
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: 110,
                     margin: EdgeInsets.only(left: 35),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/image2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
            
                    Container(
                      height: 200,
                      width: 140,
                      
                      alignment: Alignment.center,
                      child: const Text(
                        'Supermarket Guide',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ),
                  ]
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
      
            MaterialButton(
               onPressed: () async {
                
              },
              child: Container(
                height: 100,
                width: 350,
                margin: EdgeInsets.only(left: 0),
                 decoration:const BoxDecoration(
                   color: Color(0xff01ACC2),
                   borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(40),
                   bottomRight: Radius.circular(40),
                   topRight: Radius.circular(40),
                    ),
                  ),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 110,
                     margin: EdgeInsets.only(left: 30),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/image3.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
            
                    Container(
                      height: 170,
                      width: 140,
                      
                      alignment: Alignment.center,
                      child: const Text(
                        'Bill Guide',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ),
                  ]
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
      
            MaterialButton(
               onPressed: () async {
               
              },
              child: Container(
                height: 100,
                width: 350,
                margin: EdgeInsets.only(left: 0),
                 decoration:const BoxDecoration(
                   color: Color(0xff01ACC2),
                   borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(40),
                    topLeft: Radius.circular(40),
                   bottomRight: Radius.circular(40),
                   topRight: Radius.circular(40),
                 ),
                 ),
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: 110,
                      margin: EdgeInsets.only(left: 35),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/image4.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
            
                    Container(
                      height: 200,
                      width: 140,
                      
                      alignment: Alignment.center,
                      child: const Text(
                        'Dress Color Guide',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ),
                  ],
                ),
              ),
            ),
      
            const SizedBox(
              height: 30,
            ),
      
          ],
        ),
      ),
    );
  }
 }
