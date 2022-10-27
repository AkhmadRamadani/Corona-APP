// @dart=2.9
import 'package:flutter/material.dart';

class LittleCard extends StatefulWidget {
  final String type, label, jumlah, lebih;

  const LittleCard({Key key, this.type, this.label, this.jumlah, this.lebih}) : super(key: key);

  
  @override
  State<StatefulWidget> createState() => _LitteCardState();
  
}

class _LitteCardState extends State<LittleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      height: 100,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: widget.type == "Death"
                ? [Colors.orange, Colors.red]
                : widget.type == "Recovered"
                    ? [Colors.greenAccent, Colors.lime]
                    : [Colors.blueAccent, Colors.lightBlueAccent]),
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //     width: 1.0,
        //     color: widget.type == "Death"
        //         ? Colors.red
        //         : widget.type == "Recovered"
        //             ? Colors.greenAccent
        //             : Colors.blueAccent)
      ),
      child: ListView(
        children: <Widget>[
          Text(widget.jumlah,
              style: TextStyle(
                  fontSize: 26,
                  fontFamily: "Open Sans",
                  fontWeight: FontWeight.bold)),
          Text("+ " + widget.lebih,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Open Sans",
              )),
          Text(widget.label,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Open Sans",
              ))
        ],
      ),
    );
  }
}
