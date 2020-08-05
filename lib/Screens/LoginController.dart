import 'package:Corner/Components/button.dart';
import 'package:Corner/Components/text_input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LoginControllerPage());
}

class LoginControllerPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginControllerPage> {
  String _emailText, _passwordText;
  final myController = TextEditingController();

  void _showLog() {
    Navigator.of(context).pushNamed('/register');
    print("emailText " + myController.text.toString());
  }

  void _setText(String key, String context) {
    setState(() {
      key = context;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft,
          //       colors: [Colors.blueGrey, Colors.lightBlueAccent]),

          // ),
          child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 57, left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  "Log In",
                  style: TextStyle(
                      fontSize: 48,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),
              ),
              InputText(
                  label: "Email",
                  type: "Email",
                  onChangeText: (text) {
                    this._setText("_emailText", text);
                  },
                  textEditingController: myController),
              InputText(
                  label: "Password",
                  type: "Password",
                  onChangeText: (text) {
                    this._setText("_passwordText", text);
                  }),
              ButtonLogin(onPress: _showLog, label: "Sign In"),
              GestureDetector(
                  onTap: () {
                    this._showLog();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                          text: "First time here? ",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 16,
                              color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Sign Up!!!",
                                style: TextStyle(color: Colors.blueAccent))
                          ]),
                    ),
                  )),
            ],
          )
        ],
      )),
    );
  }
}
