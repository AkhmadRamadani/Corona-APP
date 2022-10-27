// @dart=2.9
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String label;
  final Function onChangeText;
  final TextEditingController textEditingController;
  final String type;

  const InputText(
      {Key key,
      this.label,
      this.onChangeText,
      this.textEditingController,
      this.type})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: widget.label,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(),
            ),
            //fillColor: Colors.green
          ),
          validator: (value) {
            if (widget.type == "Email" && value.contains("@")) {
              return "${widget.label} tidak sesuai";
            } else {
              return null;
            }
          },
          onSaved: (val) => {widget.onChangeText(val)},
          keyboardType: widget.type == "Password"
              ? TextInputType.visiblePassword
              : widget.type == "Email"
                  ? TextInputType.emailAddress
                  : TextInputType.text,
          style: const TextStyle(
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
