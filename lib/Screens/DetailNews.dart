import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailNews extends StatefulWidget {
  DetailNews({this.url, this.image, this.judul, this.date, this.content});
  final String url, image, judul, date, content;
  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  copyToClipboard(BuildContext context) {
    Clipboard.setData(new ClipboardData(text: widget.url));
    final snackBar = SnackBar(
      content: Text('Alamat LSS telah disalin ke Papan Klip',
          style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.grey[850],
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    // Scaffold.of(context).showSnackBar(
    //     SnackBar(content: Text('Alamat LSS telah disalin ke Papan Klip')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            hoverColor: Colors.transparent,
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(6)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  height: 30,
                  child: Text(
                    widget.url,
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontFamily: "Open Sans", fontSize: 14),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    copyToClipboard(context);
                  },
                  child: Icon(
                    Icons.content_copy,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
          titleSpacing: 0.0,
        ),
        body: Builder(builder: (context) {
          return Container(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              gestureNavigationEnabled: false,
            ),
          );
        }));
    // body: SingleChildScrollView(
    //   child: Column(
    //     children: <Widget>[
    //       Image(
    //         image: NetworkImage(widget.image),
    //         height: 200,
    //         width: double.infinity,
    //         fit: BoxFit.fitWidth,
    //       ),
    //       Padding(
    //         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    //         child: Column(
    //           children: <Widget>[
    //             Text(
    //               widget.judul,
    //               style: TextStyle(
    //                   fontFamily: "Roboto",
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(top: 10),
    //               child: Text(
    //                 widget.content,
    //                 style: TextStyle(
    //                   fontFamily: "Roboto",
    //                   fontSize: 16,
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(top: 10, bottom: 5),
    //               child: Row(
    //                 children: <Widget>[
    //                   Icon(
    //                     Icons.access_time,
    //                     size: 16,
    //                     color: Colors.grey[300],
    //                   ),
    //                   Text(
    //                     " " + widget.date,
    //                   )
    //                 ],
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.symmetric(vertical: 5),
    //               child: RichText(
    //                 text: TextSpan(
    //                   text: "Sumber : ",
    //                   style: TextStyle(
    //                       fontFamily: "Roboto",
    //                       fontSize: 16,
    //                       fontStyle: FontStyle.italic,
    //                       color: Colors.grey),
    //                   children: <TextSpan>[
    //                     TextSpan(
    //                       text: widget.url,
    //                       style: TextStyle(
    //                         fontSize: 16,
    //                         fontStyle: FontStyle.italic,
    //                         color: Colors.grey[200],
    //                         fontFamily: "Roboto",
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // ));
  }
}
