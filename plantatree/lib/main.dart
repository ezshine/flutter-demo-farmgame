import 'dart:async';
import 'dart:math';
import 'dart:ui' as UI;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<int> map = [
    1,1,1,1,1,
    1,1,51,1,1,
    1,1,2,1,1,
    1,1,51,1,1,
    1,1,1,1,1
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget getMapWidget(){

    Size floorSize = Size(47,36);
    Size treeSize = Size(87,87);
    
    int rowCount = 5;

    List<Positioned> all = [];

    for(int i = 0;i<map.length;i++){
      int xIndex = (i/rowCount).floor();
      int yIndex = (i%rowCount).floor();

      int floorType = map[i]%10;
      
      all.add(Positioned(
        left: xIndex*floorSize.width/2+yIndex*floorSize.width/2,
        top:yIndex*floorSize.height/2-xIndex*floorSize.height/2+100,
        child: Image.asset("assets/floor$floorType.png",width: floorSize.width,height: floorSize.height)
      ));
    }

    for(int i = 0;i<map.length;i++){
      int xIndex = (i/rowCount).floor();
      int yIndex = (i%rowCount).floor();

      int treeType = ((map[i]%100)/10).floor();
      
      if(treeType>0){
        all.add(Positioned(
          left: xIndex*floorSize.width/2+yIndex*floorSize.width/2-treeSize.width*.3,
          top:yIndex*floorSize.height/2-xIndex*floorSize.height/2+135-treeSize.height,
          child: Image.asset("assets/youzi$treeType.png",width: treeSize.width,height: treeSize.height)
        ));
      }
    }

    return Stack(
      children: all,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child:Center(
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(double.infinity),
            minScale: 0.2,
            maxScale: 2,
            child: Container(
              width: 300,
              height: 300,
              child:getMapWidget()
            ),
          )
        ),
        color: Colors.grey,
      )
    );
  }
}