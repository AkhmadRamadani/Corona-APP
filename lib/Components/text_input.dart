import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  InputText({Key key, @required this.label, this.onChangeText, this.type, this.textEditingController})
      : super(key: key);

  final String label;
  final Function onChangeText;
  final TextEditingController textEditingController;
  final String type;
  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.black
            // ),
            // borderRadius: BorderRadius.circular(6)
            ),
        child: TextFormField(
          decoration: new InputDecoration(
            labelText: widget.label,
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25),
              borderSide: new BorderSide(),
            ),
            //fillColor: Colors.green
          ),
          validator: (val) {
            // if (val.length == 0) {
            //   return widget.label + " cannot be empty";
            // } else {
            //   return null;
            // }
            if (widget.type == "Email" && !val.contains("@")) {
              return widget.label + " tidak sesuai";
            }else{
              return null;
            }
          },
          onSaved: (val) => {widget.onChangeText(val)},
          keyboardType: widget.type == "Password" ? TextInputType.visiblePassword :
           widget.type == "Email" ? TextInputType.emailAddress : TextInputType.values,
          style: new TextStyle(
            fontFamily: "Open Sans",
          ),
          obscureText: widget.type == "Password" ? true : false,
          controller: widget.textEditingController,
          // onChanged: (text) => {widget.onChangeText(text)}
        ),
        // TextField(
        //   style: TextStyle(
        //     color: Colors.black,
        //   ),
        //   onChanged: (text) => {widget.onChangeText(text)},
        //   obscureText: widget.label == "Password" ? true : false,
        //   decoration: InputDecoration(
        //     fillColor: Colors.black,
        //     labelText: widget.label,
        //     labelStyle: TextStyle(
        //       color: Colors.black87,
        //     ),
        //   ),
        // ),
        // child: Row(
        //   children: <Widget>[
        //     Container(
        //       height: 26,
        //       width: 26,
        //       decoration: BoxDecoration(
        //         image: DecorationImage(image: AssetImage("assets/images/user.png"))
        //       ),
        //     ),
        //     TextField(
        //       style: TextStyle(
        //         color: Colors.black,
        //       ),
        //       obscureText: widget.label == "Password" ? true : false,
        //       decoration: InputDecoration(
        //         border: InputBorder.none,
        //         fillColor: Colors.black,
        //         hintText: widget.label
        //       ),
        //     ),
        //   ],
        // )
      ),
    );
  }
}
