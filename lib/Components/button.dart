// @dart=2.9
import 'package:flutter/material.dart';

class ButtonLogin extends StatefulWidget {
  final Function onPress;
  final String label;

  const ButtonLogin({Key key, this.onPress, this.label}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 40, left: 40),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.blue[300],
          //     blurRadius: 10.0, // has the effect of softening the shadow
          //     spreadRadius: 1.0, // has the effect of extending the shadow
          //     offset: Offset(
          //       5.0, // horizontal, move right 10
          //       5.0, // vertical, move down 10
          //     ),
          //   ),
          // ],
          border: Border.all(color: Colors.black, width: 1),
          color: Color(0xfffffff),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ElevatedButton(
          onPressed: () => widget.onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.label,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Open Sans"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
