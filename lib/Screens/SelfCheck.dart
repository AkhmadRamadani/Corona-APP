// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SelfCheck extends StatefulWidget {
  @override
  _SelfCheckState createState() => _SelfCheckState();
}

class _SelfCheckState extends State<SelfCheck> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Self Check"),
        ),
        body: Container(
            child: WebView(
          initialUrl:
              "https://checkupcovid19.jatimprov.go.id/covid19/#!/checkup/",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          gestureNavigationEnabled: false,
        )));
    // WebviewScaffold(
    //   url: "https://checkupcovid19.jatimprov.go.id/covid19/#!/checkup/",
    //   hidden: true,

    // )
  }
}
