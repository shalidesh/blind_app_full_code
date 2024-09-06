import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:flutter_tts/flutter_tts.dart';

import '../ColorDetector.dart';
import '../Navigation.dart';
import '../SuperMarkets.dart';


class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  FlutterTts ftts = FlutterTts();
  String instruction_text="";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      instruction_text="hi,i am Alexa.Here are the brief instructions for using the app.Double tap the screen and say “navigation” to access the indoor navigation function.Double tap the screen and say “super market” to access the super market object detection function.Double tap the screen and say “detection” to access the dress colour detection and recommendation function.";
      var result1 = await ftts.speak(instruction_text);
      if (result1 == 1) {
        // Speaking
      } else {
        // Not speaking
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 300.0,
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
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            height: MediaQuery.of(context).size.height-100, 
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
            child: TextHighlight(
              text: _text,
              words: _highlights,
              textStyle: const TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
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
              if (val.recognizedWords.toLowerCase() == "navigation") {
                // Stop listening and perform any actions you want
                 Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Navigation()),
                    );
                  setState(() => _isListening = false);
                  _speech.stop();
                // ...
              }
              else if (val.recognizedWords.toLowerCase() == "supermarket") {
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
}