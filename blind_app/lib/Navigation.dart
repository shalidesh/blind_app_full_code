import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:bindappp/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:async';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'dart:isolate';
import 'dart:collection';

import 'Dashboard.dart';


class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  List<dynamic>? _recognitions;

  late CameraController controller;
  late FlutterVision vision;
  late List<Map<String, dynamic>> yoloResults;
  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  int _taps = 0;
  FlutterTts ftts = FlutterTts();
  bool isSpeaking = false;

  double CONFIDENCE_THRESHOLD = 0.4;
  double NMS_THRESHOLD = 0.3;

  //  Distance constants 
  double KNOWN_DISTANCE = 62; //INCHES

  double CHAIR_WIDTH = 21; //INCHES
  double TABLE_WIDTH = 33; //INCHES
  double CABINET_DOOR_WIDTH = 15; //INCHES
  double DOOR_WIDTH = 25; //INCHES
  double REFREGERATOR_DOOR_WIDTH = 21; //INCHES
  double WINDOW_WIDTH = 33; //INCHES
  double CABINET_WIDTH = 15; //INCHES
  double COUCH_WIDTH = 33; //INCHES
  double OPEN_DOOR_WIDTH =25; //INCHES
  double POLE_WIDTH = 21; //INCHES
  double SOFA_WIDTH = 50; //INCHES



  double chair_width_in_rf = 240.9855;
  double table_width_in_rf = 378.41183;
  double cabinet_door_width_in_rf = 200.000;
  double door_width_in_rf = 250.0000;
  double refrigerator_door_width= 240.9855;
  double window_width_in_rf = 378.41183;
  double cabinet_width= 200.9855;
  double couch_width_in_rf = 378.41183;
  double opendoor_width_in_rf = 250.3654;
  double pole_width= 240.9855;
  double sofa_width_in_rf = 525.41183;

  double focal_chair=0.0;
  double focal_table=0.0;
  double focal_cabinetdoor=0.0;
  double focal_door=0.0;
  double focal_refregator=0.0;
  double focal_window=0.0;
  double focal_cabinet=0.0;
  double focal_couch=0.0;
  double focal_opendoor=0.0;
  double focal_pole=0.0;
  double focal_sofa=0.0;

  double distance=0.0;
  String distance_text='';

  // Create a queue to store the names of detected objects
  final Queue<String> objectQueue = Queue<String>();

  @override
  void initState() {
    super.initState();
    initCamera();
    ftts.setCompletionHandler(() {
        setState(() {
          isSpeaking = false;
        });
      });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ftts.setSpeechRate(0.5); 
      var result1 = await ftts.speak(
          "please,left to right drag on the screen for start navigation and down to up drag on the screen for stop.right to left drag for main menu");
      if (result1 == 1) {
        // Speaking
      } else {
        // Not speaking
      }
      
    });

  }

  double focalLengthFinder(double measuredDistance, double realWidth, double widthInRf) {
    double focalLength = (widthInRf * measuredDistance) / realWidth;
    return focalLength;
}

double distanceFinder(double focalLength, double realObjectWidth, double widthInFrame) {
    double distance = (realObjectWidth * focalLength) / widthInFrame;
    return distance;
}

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
        labels: 'assets/navigation/navigation_3.txt',
        modelPath: 'assets/navigation/navigation_3.tflite',
        modelVersion: "yolov5",
        numThreads: 2,
        useGpu: false);
    setState(() {
      isLoaded = true;
    });

  }

  initCamera() async {
    final cameras = await availableCameras();
    vision = FlutterVision();
    controller = CameraController(cameras[0], ResolutionPreset.low);
    controller.initialize().then((value) {
      loadYoloModel().then((value) {

        focal_chair = focalLengthFinder(KNOWN_DISTANCE, CHAIR_WIDTH, chair_width_in_rf);
        focal_table = focalLengthFinder(KNOWN_DISTANCE, TABLE_WIDTH, table_width_in_rf);

        print(focal_chair);
        print(focal_table);

        setState(() {
          isLoaded = true;
          isDetecting = false;
          yoloResults = [];
        });
      });
    });
 
  }

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
  final result = await vision.yoloOnFrame(
      bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
      imageHeight: cameraImage.height,
      imageWidth: cameraImage.width,
      iouThreshold: 0.4,
      confThreshold: 0.4,
      classThreshold: 0.5);
  if (result.isNotEmpty) {
    setState(() {
      yoloResults = result;
    });
    

    for (var object in yoloResults) {

      // Wait for the previous text-to-speech to finish
      while (isSpeaking) {
        await Future.delayed(Duration(milliseconds: 500));
      }

      if (object["tag"]== 'chair'  && object['box'][4] * 100>80){
        
        distance = distanceFinder(focal_chair, CHAIR_WIDTH, (object["box"][2] - object["box"][0]));

        if(distance<150){

          //  distance_text='Chair in ${distance.toStringAsFixed(0)} inches';
          distance_text='chair too close';

          var result1 = await ftts.speak(distance_text);
          if (result1 == 1) {
            // Speaking
            setState(() {
              isSpeaking = true;
            });
          } else {
            // Not speaking
          }

        }
       
      }
        else if(object["tag"]== 'cabinetDoor'  && object['box'][4] * 100>80 ){
        
        distance = distanceFinder(focal_chair, CHAIR_WIDTH, (object["box"][2] - object["box"][0]));

        if(distance<150){
          // distance_text='cabinet door in ${distance.toStringAsFixed(0)} inches';
          distance_text='cabinet door too close';
          //objectQueue.add('cabinet door');

          var result1 = await ftts.speak(distance_text);
          if (result1 == 1) {
            // Speaking
            setState(() {
              isSpeaking = true;
            });
          } else {
            // Not speaking
          }

        }
        
      }
      else if(object["tag"]== 'table'  && object['box'][4] * 100>80){
        distance = distanceFinder(focal_table, TABLE_WIDTH,(object["box"][2] - object["box"][0]));

        if(distance<150){

          //  distance_text=' Table ${distance.toStringAsFixed(1)}  inches';
          // distance_text=' Table in ${distance.toStringAsFixed(0)} inches';
          distance_text='table too close';
          //objectQueue.add('table');

          var result1 = await ftts.speak(distance_text);
          if (result1 == 1) {
            // Speaking
            setState(() {
              isSpeaking = true;
            });
          } else {
            // Not speaking
          }

        }
       
      }
       else if(object["tag"]== 'window'  && object['box'][4] * 100>80){
        distance = distanceFinder(focal_table, TABLE_WIDTH,(object["box"][2] - object["box"][0]));

        if(distance<150){

          //  distance_text=' Table ${distance.toStringAsFixed(1)}  inches';
          // distance_text='window in ${distance.toStringAsFixed(0)} inches';
          distance_text='window too close';
          //objectQueue.add('window');
          var result1 = await ftts.speak(distance_text);
          if (result1 == 1) {
            // Speaking
            setState(() {
              isSpeaking = true;
            });
          } else {
            // Not speaking
          }

        }
      }
      else if(object["tag"]== 'door'  && object['box'][4] * 100>80){
        distance = distanceFinder(focal_table, TABLE_WIDTH,(object["box"][2] - object["box"][0]));

        if(distance<150){
          // distance_text='door in ${distance.toStringAsFixed(0)} inches';
          distance_text='door too close';
          //objectQueue.add('door');
    
          var result1 = await ftts.speak(distance_text);
          if (result1 == 1) {
            // Speaking
            setState(() {
              isSpeaking = true;
            });
          } else {
            // Not speaking
          }

        }
        
       
      }

      else if(object["tag"]== 'refrigeratorDoor'  && object['box'][4] * 100>80){
        distance = distanceFinder(focal_table, TABLE_WIDTH,(object["box"][2] - object["box"][0]));

        if(distance<150){

          // distance_text='refrigerator in ${distance.toStringAsFixed(0)} inches';
          distance_text='refrigerator too close';
          //objectQueue.add('refrigerator');
    
          var result1 = await ftts.speak(distance_text);
          if (result1 == 1) {
            // Speaking
            setState(() {
              isSpeaking = true;
            });
          } else {
            // Not speaking
          }

        }
        
       
      }
    }
   
    print(result);
  }
}

Future<void> startDetection() async {
setState(() {
  isDetecting = true;
});
if (controller.value.isStreamingImages) {
  return;
}
await controller.startImageStream((image) async {
  if (isDetecting) {
    cameraImage = image;
    yoloOnFrame(image);
  }
});
}

Future<void> stopDetection() async {
  setState(() {
    isDetecting = false;
    yoloResults.clear();
  });
}

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
  if (yoloResults.isEmpty) return [];
  double factorX = screen.width / (cameraImage?.height ?? 1);
  double factorY = screen.height / (cameraImage?.width ?? 1);

  Color colorPick = const Color.fromARGB(255, 50, 233, 30);

  return yoloResults.map((result) {
    if (result["tag"] == 'chair') {
      distance = distanceFinder(focal_chair, CHAIR_WIDTH, (result["box"][2] - result["box"][0]));
    } else if (result["tag"] == 'cabinet') {
      distance = distanceFinder(focal_chair, CHAIR_WIDTH, (result["box"][2] - result["box"][0]));
    } else if (result["tag"] == 'table') {
      distance = distanceFinder(focal_table, TABLE_WIDTH, (result["box"][2] - result["box"][0]));
    }
    else{
      distance = distanceFinder(focal_table, TABLE_WIDTH, (result["box"][2] - result["box"][0]));
    }
    print('distance is $distance inches');

    // Check if the tag is "table" or "chair"
    if (result["tag"] == 'table'  && result['box'][4] * 100>80 ||
     result["tag"] == 'chair' && result['box'][4] * 100>80   || 
     result["tag"]== 'cabinet door' && result['box'][4] * 100>80 || 
     result["tag"] == 'window'  && result['box'][4] * 100>80 || 
     result["tag"] == 'door'  && result['box'][4] * 100>80 ||
     result["tag"] == 'refrigeratorDoor'  && result['box'][4] * 100>80) {
      
      return Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY,
        width: (result["box"][2] - result["box"][0]) * factorX,
        height: (result["box"][3] - result["box"][1]) * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}% ${distance.toStringAsFixed(0)} inches",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    } else {
      // Return an empty container for other tags
      return Container();
    }
  }).toList();
}


    @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: Text("Model not loaded, waiting for it"),
        ),
      );
    }
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) async {
          if ((details.primaryVelocity ?? 0) > 0) {
            // User completed a left-to-right drag gesture
            // Start your process 
            var result1 = await ftts.speak(
                "started");
            if (result1 == 1) {
              // Speaking
            } else {
              // Not speaking
            }
            await startDetection();
          }
        },
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx < 0) {
            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>const DashBoard()),
                    );
          }
        },
        onVerticalDragEnd: (details) async {
            if ((details.primaryVelocity ?? 0) < 0) {
              // User completed a down-to-up drag gesture
              // Start your process here
                var result1 = await ftts.speak(
                        "stoped");
                    if (result1 == 1) {
                      // Speaking
                    } else {
                      // Not speaking
                    }
             
                stopDetection();
                        
              
            }
          },
        child: Stack(
          fit: StackFit.expand,
          children: [
            AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(
                controller,
              ),
            ),
            ...displayBoxesAroundRecognizedObjects(size),
            Positioned(
              bottom: 75,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 5, color: Colors.white, style: BorderStyle.solid),
                ),
                child: isDetecting
                    ? IconButton(
                        onPressed: () async {
                          stopDetection();
                        },
                        icon: const Icon(
                          Icons.stop,
                          color: Colors.red,
                        ),
                        iconSize: 50,
                      )
                    : IconButton(
                        onPressed: () async {
                          await startDetection();
                        },
                        icon: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        iconSize: 50,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() async{
    super.dispose();
    controller.dispose();
    await vision.closeYoloModel();
  }
}
