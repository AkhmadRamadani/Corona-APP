// @dart=2.9
import 'package:Corner/Components/BigNewsCard.dart';
import 'package:Corner/Screens/DetailNews.dart';
import 'package:Corner/Utils/NewsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class News extends StatefulWidget {
  const News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<Articles> _newsData = [];
  bool _loading = true;

  Future getNews() async {
    // _loading = true;
    String url =
        "http://newsapi.org/v2/top-headlines?country=id&category=health&apiKey=2ec972076e064d51876580dcc22bf8f1";
    http.Response res = await http.get(url);
    final resBody = json.decode(res.body);
    // print(resBody[0].toString());
    // print(resBody.runtimeType);

    NewsModel newsModel = NewsModel.fromJson(resBody);
    // List<News> data = (resBody as List).map((e) => null);
    // Map<String, dynamic> res
    setState(() {
      _newsData = newsModel.articles;
      // _newsModel = resBody.map((item) => NewsModel.fromJson(item)).toList();
      // _newsModel = (resBody as List).map((e) => NewsModel.fromJson(e)).toList();
    });
  }

  Future _refreshData() async {
    await this.getNews();
    setState(() {
      _loading = false;
    });
  }

  @override
  initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Berita"),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: _loading == true
            ? Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (context, index) => ElevatedButton(
                  onPressed: () {
                    pushNewScreen(context,
                        screen: DetailNews(
                          date: _newsData[index].publishedAt.substring(0, 10),
                          image: _newsData[index].urlToImage,
                          judul: _newsData[index].title,
                          url: _newsData[index].url,
                          content: '',
                        ),
                        withNavBar: false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: BigNewsCard(
                      imageNews: _newsData[index].urlToImage,
                      date: _newsData[index].publishedAt.substring(0, 10),
                      judul: _newsData[index].title,
                      deskripsi: _newsData[index].description,
                    ),
                  ),
                ),
                itemCount: _newsData.length,
              ),
      ),
    );
  }
}
