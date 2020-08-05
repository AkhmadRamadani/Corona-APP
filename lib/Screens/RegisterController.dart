import 'package:flutter/material.dart';

void main(){
  runApp(RegisterController());
}

class RegisterController extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RegisterController> {
  
  void _showLog(){
    print("test");
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        
        body: Center(child: Text("Text for register page"),),
        floatingActionButton: FloatingActionButton(
          onPressed: _showLog,
          child: Icon(Icons.add)
          ),
      );   
    }
}
