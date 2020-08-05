import 'package:flutter/material.dart';

class RankingCard extends StatefulWidget {
  RankingCard({this.type, this.iso2, this.country, this.jumlah, this.index});
  final String type, iso2, country, jumlah;
  final int index;
  // final double jumlah;
  @override
  _RankingCardState createState() => _RankingCardState();
}

class _RankingCardState extends State<RankingCard> {
  String type = "Death";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      margin: EdgeInsets.only(
          top: widget.index == 0 ? 10 : 5, bottom: 5, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        image: DecorationImage(
            image: AssetImage("assets/images/bg1.png"), fit: BoxFit.cover),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: widget.type == "Death"
                ? [Colors.red, Colors.orange]
                : widget.type == "Recovered"
                    ? [Colors.greenAccent, Colors.green[200]]
                    : [Colors.blueAccent, Colors.lightBlueAccent]),

        // image: Image(image: AssetImage("assets/images/bg-2.png")),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10, right: 5),
              child: Text(
                "${widget.index + 1}",
                style: TextStyle(fontFamily: "Open Sans", fontSize: 40),
              ),
            ),
            flex: 1,
          ),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image(
                          image: NetworkImage("https://www.countryflags.io/" +
                              widget.iso2 +
                              "/flat/64.png"),
                          width: 60,
                          height: 50),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            widget.country,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Open Sans"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    widget.jumlah.substring(0, widget.jumlah.length - 3) +
                        " Cases",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Open Sans"),
                  ),
                  // Padding(
                  //   // padding: EdgeInsets.only(b),
                  //   child:
                  // )
                ],
              ))
        ],
      ),
    );
  }
}
