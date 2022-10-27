// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class BigNewsCard extends StatefulWidget {
  final String imageNews, date, judul, deskripsi;

  const BigNewsCard({Key key, this.imageNews, this.date, this.judul, this.deskripsi}) : super(key: key);

  @override
  _StateBigNewsCard createState() => _StateBigNewsCard();
}

class _StateBigNewsCard extends State<BigNewsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 2,
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              image:NetworkImage(widget.imageNews),
            ),
          ),
          // ClipRRect(
          //     child: Image(
          //       image: widget.imageNews != null
          //           ? NetworkImage(widget.imageNews)
          //           : AssetImage("assets/images/bg-22.png"),
          //       height: double.infinity,
          //       width: double.infinity,
          //       fit: BoxFit.cover,
          //     ),
          //     borderRadius: BorderRadius.circular(10)),
          Container(
            padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      Colors.deepPurple.shade800,
                    ],
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Icon(Icons.access_time, size: 20.0),
                        Text(" ${widget.date}")
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(widget.judul,
                            style: const TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis),
                        Text(
                          widget.deskripsi,
                          style: const TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 12,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              )
        ],
      ),
    );
  }
}
