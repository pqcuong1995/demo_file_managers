import 'package:demo_file_manager/BLOC/base/StatefulBase.dart';
import 'package:demo_file_manager/Utils/NavDrawer.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WelcomeScreenState();
  }
}

class WelcomeScreenState extends StatefulBaseState<WelcomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Container(
        child: ListView(
          children: [
            Image.asset('images/fsecure.jpg'),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Align(alignment: Alignment.center,child: Text('Welcome to File security', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 26.0),),),
            )
          ],
        ),
      ),
    );
  }
}