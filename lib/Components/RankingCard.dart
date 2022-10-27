// @dart=2.9
import 'package:flutter/material.dart';

class RankingCard extends StatefulWidget {
  final String type, iso2, country, jumlah;
  final int index;

  const RankingCard(
      {Key key, this.type, this.iso2, this.country, this.jumlah, this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RankingCardState();
  // final double jumlah;
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

        image: const DecorationImage(
            image: AssetImage("assets/images/bg1.png"), fit: BoxFit.cover),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: widget.type == "Death"
                ? [Colors.red, Colors.orange]
                : widget.type == "Recovered"
                    ? [Colors.greenAccent, Colors.green.shade200]
                    : [Colors.blueAccent, Colors.lightBlueAccent]),

        // image: Image(image: AssetImage("assets/images/bg-2.png")),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 5),
              child: Text(
                "${widget.index + 1}",
                style: const TextStyle(fontFamily: "Open Sans", fontSize: 40),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 60,
                        height: 50,
                      ),
                      // Image(
                      //     image: NetworkImage("https://www.countryflags.io/${widget.iso2}/flat/64.png"),
                      //     width: 60,
                      //     height: 50),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            widget.country,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Open Sans",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "${widget.jumlah.substring(0, widget.jumlah.length - 3)} Cases",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Open Sans",
                    ),
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
