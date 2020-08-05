import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class NewsCard extends StatefulWidget {
  NewsCard({this.imageNews, this.date, this.judul, this.deskripsi, this.index});
  final String imageNews, date, judul, deskripsi;
  int index;

  @override
  _StateNewsCard createState() => _StateNewsCard();
}

class _StateNewsCard extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 2,
      width: MediaQuery.of(context).size.width - 60,
      margin: EdgeInsets.only(left: widget.index == 0 ? 15 : 5, right: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: <Widget>[
          ClipRRect(
              child: Image(
                image: widget.imageNews != null
                    ? NetworkImage(widget.imageNews)
                    : AssetImage("assets/images/bg-22.png"),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10)),
          Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.access_time, size: 20.0),
                        Text(" " + widget.date)
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
                            style: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis),
                        Text(
                          widget.deskripsi,
                          style: TextStyle(
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
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      Colors.deepPurple[800],
                    ],
                  )))
        ],
      ),
    );
  }
}
