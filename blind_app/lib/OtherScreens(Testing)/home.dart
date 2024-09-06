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

// late List<CameraDescription> cameras;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          "hi,i am Alexa.Here are the brief instructions for using the app.Double tap the screen and say “market” to access the super market object detection function.Double tap the screen and say “detection” to access the dress colour detection and recommendation function.");
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Blind App"),
          backgroundColor: Colors.orangeAccent,
        ),
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
          child: Container(
            color: const Color.fromARGB(255, 114, 47, 47),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 75.0,
                  //     color: Colors.green,
                  //     child: Row(
                  //       children: [
                  //         Expanded(
                  //           flex: 1,
                  //           child: Center(
                  //             // Add your Lottie animation here
                  //             child: Lottie.asset('assets/navigation.json'),
                  //           ),
                  //         ),
                  //          Expanded(
                  //           flex: 3,
                  //           child: Container(
                  //             color: Colors.blue,
                  //             child: const Center(
                  //               child: Text("Navigation Guide",
                  //                   style: TextStyle(
                  //                         fontSize: 25,
                  //                         color: Colors.white, // Change the font color here
                  //                         fontFamily: 'Roboto', // Change the font type here
                  //                         fontWeight:FontWeight.bold,
                                                    
                  //                   )),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 75.0,
                      color: Colors.green,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              // Add your Lottie animation here
                              child: Lottie.asset('assets/supermarket.json'),
                            ),
                          ),
                           Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text("Super Market Guide",
                                    style: TextStyle(
                                      fontSize: 25,
                                            color: Colors.white, // Change the font color here
                                            fontFamily: 'Roboto', // Change the font type here
                                            fontWeight:FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 75.0,
                      color: Colors.green,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              // Add your Lottie animation here
                              child: Lottie.asset('assets/dress.json'),
                            ),
                          ),
                         Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text("Dress Color Guide",
                                    style: TextStyle(
                                      fontSize: 25,
                                            color: Colors.white, // Change the font color here
                                            fontFamily: 'Roboto', // Change the font type here
                                            fontWeight:FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 75.0,
                  //     color: Colors.green,
                  //     child: Row(
                  //       children: [
                  //         Expanded(
                  //           flex: 1,
                  //           child: Center(
                  //             // Add your Lottie animation here
                  //             child: Lottie.asset('assets/bill.json'),
                  //           ),
                  //         ),
                  //          Expanded(
                  //           flex: 3,
                  //           child: Container(
                  //             color: Colors.blue,
                  //             child: const Center(
                  //               child: Text("Bill Guide",
                  //                   style: TextStyle(
                  //                     fontSize: 25,
                  //                           color: Colors.white, // Change the font color here
                  //                           fontFamily: 'Roboto', // Change the font type here
                  //                           fontWeight:FontWeight.bold,
                  //                   )),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
