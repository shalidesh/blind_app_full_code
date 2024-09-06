import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.alphaBlend(Colors.white10, Colors.black38),
      body: Column(
       
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

        const SizedBox(
          height: 150,
        ),
        
          MaterialButton(
            onPressed: () async {
              
            },
            child: Container(
              margin:const EdgeInsets.only(left: 20),
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
                        image: AssetImage('assets/land.png'),
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
              margin: EdgeInsets.only(left: 20),
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
                        image: AssetImage('assets/land.png'),
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
              margin: EdgeInsets.only(left: 20),
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
                        image: AssetImage('assets/land.png'),
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
              margin: EdgeInsets.only(left: 20),
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
                        image: AssetImage('assets/land.png'),
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

          Container(
            height: 100,
            width: 350,
            margin: EdgeInsets.only(left: 8),
             
           child: Row(
           children: [
               Container(
                height: 200,
                width: 170,
            // Container 1 content
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(''),
                      IconButton(
                         onPressed: () {
                              // Microphone icon button pressed
                            },
                         icon: const Icon(Icons.surround_sound_rounded, color: Color(0xff01ACC2), size: 60)
          ),
        ],
      ),
    ),
    const SizedBox(
      width: 30,
    ),
    Container(
      height: 200,
      width: 140,
      // Container 2 content
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(''),
          IconButton(
            onPressed: () {
              // Microphone icon button pressed
            },
            icon: const Icon(Icons.mic, color: Color(0xff01ACC2), size: 60)
          ),
        ],
      ),
    ),
  ],
)

          )

        ],
      ),
    );
  }
 }
