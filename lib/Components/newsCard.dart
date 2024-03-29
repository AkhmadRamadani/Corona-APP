// @dart=2.9
import 'package:flutter/material.dart';

class NewsCard extends StatefulWidget {
  final String imageNews, date, judul, deskripsi;
  int index;

  NewsCard(
      {Key key,
      this.imageNews,
      this.date,
      this.judul,
      this.deskripsi,
      this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateNewsCard();
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
            borderRadius: BorderRadius.circular(10),
            child: Image(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              image: NetworkImage(widget.imageNews ??
                  "https://via.placeholder.com/150/5271FF/FFFFFF/?text=newsapi.org"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
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
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.access_time, size: 20.0),
                      Text("${widget.date}" ?? "News Api Org")
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(widget.judul ?? "News Api Org",
                          style: TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis),
                      Text(
                        widget.deskripsi ?? "News Api Org",
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
          )
        ],
      ),
    );
  }
}
