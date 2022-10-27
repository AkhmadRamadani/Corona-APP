// @dart=2.9
import 'package:Corner/Components/newsCard.dart';
import 'package:Corner/Screens/DetailNews.dart';
import 'package:Corner/Screens/SelfCheck.dart';
import 'package:Corner/Utils/NewsModel.dart';
import 'package:Corner/Utils/String.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  @override
  _StateHomePage createState() => _StateHomePage();
}

class _StateHomePage extends State<HomePage> {
  // List newsData;
  List<Articles> _newsData = [];
  bool _loading = false;

  Future getNews() async {
    _loading = true;
    String url =
        "http://newsapi.org/v2/top-headlines?country=id&category=health&apiKey=2ec972076e064d51876580dcc22bf8f1";
    http.Response res = await http.get(url);
    final resBody = json.decode(res.body);
    // print(resBody[0].toString());
    print(resBody.runtimeType);

    NewsModel newsModel = NewsModel.fromJson(resBody);
    setState(() {
      _newsData = newsModel.articles;
      _loading = false;
    });
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    }
    if (hour < 17) {
      return 'Selamat Siang';
    }
    return 'Selamat Malam';
  }

  Future _refreshData() async {
    await this.getNews();
  }

  @override
  initState() {
    super.initState();
    getNews();
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Beranda"),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            // padding: EdgeInsets.only(right: 15, left: 15),
            child: _loading == true
                ? Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                        child: Text(greeting(),
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto")),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 25.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      child: PageView(
                                        controller: pageController,
                                        children: <Widget>[
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Colors.lightGreen.shade400,
                                                        Colors.lightBlue
                                                      ])),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15,
                                                        bottom: 5,
                                                        left: 15,
                                                        right: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          child: Icon(
                                                              Icons.close,
                                                              size: 36,
                                                              color:
                                                                  Colors.white),
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: Icon(
                                                              Icons.arrow_right,
                                                              size: 36,
                                                              color:
                                                                  Colors.white),
                                                          onTap: () {
                                                            pageController.animateToPage(
                                                                1,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        400),
                                                                curve: Curves
                                                                    .easeIn);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    child: Text(
                                                      "Apa itu Covid 19?",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "Open Sans"),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: Image(
                                                      image: AssetImage(
                                                          "assets/images/search_engine_.png"),
                                                      height: 200,
                                                      width: 200,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(15),
                                                    child: Text(
                                                      AppConstants
                                                          .APA_ITU_COVID,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontFamily: "Roboto"),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Colors.lightGreen.shade400,
                                                        Colors.lightBlue
                                                      ])),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15,
                                                        bottom: 5,
                                                        left: 15,
                                                        right: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          child: Icon(
                                                              Icons.arrow_left,
                                                              size: 36,
                                                              color:
                                                                  Colors.white),
                                                          onTap: () {
                                                            pageController.animateToPage(
                                                                0,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        400),
                                                                curve: Curves
                                                                    .easeIn);
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: Icon(
                                                              Icons.arrow_right,
                                                              size: 36,
                                                              color:
                                                                  Colors.white),
                                                          onTap: () {
                                                            pageController.animateToPage(
                                                                2,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        400),
                                                                curve: Curves
                                                                    .easeIn);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15),
                                                    child: Text(
                                                      "Gejala Covid 19",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "Open Sans"),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3.5,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Image(
                                                                  image: AssetImage(
                                                                      "assets/images/fever.png"),
                                                                  height: 100.0,
                                                                  width: 100.0,
                                                                ),
                                                                Text(
                                                                  "Demam",
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3.5,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Image(
                                                                  image: AssetImage(
                                                                      "assets/images/cough.png"),
                                                                  height: 100.0,
                                                                  width: 100.0,
                                                                ),
                                                                Text(
                                                                  "Batuk Kering",
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3.5,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Image(
                                                                  image: AssetImage(
                                                                      "assets/images/capek.png"),
                                                                  height: 100.0,
                                                                  width: 100.0,
                                                                ),
                                                                Text(
                                                                  "Rasa Lelah",
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(15),
                                                    child: Text(
                                                      AppConstants.GEJALA_COVID,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: "Roboto"),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.lightGreen.shade400,
                                                      Colors.lightBlue
                                                    ])),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 15,
                                                      bottom: 5,
                                                      left: 15,
                                                      right: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        child: Icon(
                                                            Icons.arrow_left,
                                                            size: 36,
                                                            color:
                                                                Colors.white),
                                                        onTap: () {
                                                          pageController.animateToPage(
                                                              1,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      400),
                                                              curve: Curves
                                                                  .easeIn);
                                                        },
                                                      ),
                                                      GestureDetector(
                                                        child: Icon(Icons.close,
                                                            size: 36,
                                                            color:
                                                                Colors.white),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Text(
                                                    "Pencegahan Covid 19",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "Open Sans"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3.5,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Image(
                                                                image: AssetImage(
                                                                    "assets/images/wearing_a_mask_.png"),
                                                                height: 100.0,
                                                                width: 100.0,
                                                              ),
                                                              Text(
                                                                "Pakai Masker",
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3.5,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Image(
                                                                image: AssetImage(
                                                                    "assets/images/washing_hands.png"),
                                                                height: 100.0,
                                                                width: 100.0,
                                                              ),
                                                              Text(
                                                                "Cuci Tangan",
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3.5,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Image(
                                                                image: AssetImage(
                                                                    "assets/images/reading_a_book.png"),
                                                                height: 100.0,
                                                                width: 100.0,
                                                              ),
                                                              Text(
                                                                "Tetap di Rumah",
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Text(
                                                    AppConstants
                                                        .PENCEGAHAN_COVID,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Roboto"),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    elevation: 0.0,
                                  ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 15, bottom: 15, right: 15, left: 15),
                          height: 150,
                          padding:
                              EdgeInsets.only(top: 50, right: 15, left: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/Untitled-1.png"),
                                fit: BoxFit.cover),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.grey, Colors.blueAccent]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Apa itu COVID-19?",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Open Sans"),
                              ),
                              Text(
                                "Tekan untuk mempelajari tentang Covid-19 secara singkat",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: "Open Sans"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 15, right: 15, left: 15),
                        height: 190,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.lightBlue, Colors.lightGreen]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Pencegahan",
                                    style: TextStyle(
                                      fontFamily: "Open Sans",
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      child: Column(
                                        children: <Widget>[
                                          Image(
                                            image: AssetImage(
                                                "assets/images/wearing_a_mask_.png"),
                                            height: 100.0,
                                            width: 100.0,
                                          ),
                                          Text(
                                            "Pakai Masker",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      child: Column(
                                        children: <Widget>[
                                          Image(
                                            image: AssetImage(
                                                "assets/images/washing_hands.png"),
                                            height: 100.0,
                                            width: 100.0,
                                          ),
                                          Text(
                                            "Cuci Tangan",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      child: Column(
                                        children: <Widget>[
                                          Image(
                                            image: AssetImage(
                                                "assets/images/reading_a_book.png"),
                                            height: 100.0,
                                            width: 100.0,
                                          ),
                                          Text(
                                            "Tetap di Rumah",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 180,
                        // padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.only(bottom: 15, right: 15, left: 15),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/bg1.png"),
                                fit: BoxFit.cover),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.indigo.shade800,
                                  Colors.indigo.shade200
                                ]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Image(
                                  image: AssetImage(
                                    "assets/images/doctor.png",
                                  ),
                                  height: 120,
                                  fit: BoxFit.cover),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Lakukan pemeriksaan mandiri",
                                      style: TextStyle(
                                        fontFamily: "Open Sans",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Ikuti perintah dan jawab pertanyaannya untuk melakukan test mandiri",
                                      style: TextStyle(
                                        fontFamily: "Open Sans",
                                        fontSize: 14,
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          pushNewScreen(context,
                                              screen: SelfCheck(),
                                              withNavBar: false);
                                        },
                                        child: Container(
                                          width: 80,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                style: BorderStyle.solid,
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text("Periksa"),
                                        )),
                                  ],
                                ),
                              ),
                              flex: 2,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 15, left: 15, right: 15),
                        child: Text("Berita Harian",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Roboto")),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 2,
                          child: ListView.builder(
                            itemBuilder: (context, index) => ElevatedButton(
                              onPressed: () {
                                pushNewScreen(context,
                                    screen: DetailNews(
                                      content: _newsData[index].content,
                                      date: _newsData[index]
                                          .publishedAt
                                          .substring(0, 10),
                                      image: _newsData[index].urlToImage,
                                      judul: _newsData[index].title,
                                      url: _newsData[index].url,
                                    ),
                                    withNavBar: false);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: NewsCard(
                                  index: index,
                                  imageNews: _newsData[index].urlToImage,
                                  date: _newsData[index]
                                      .publishedAt
                                      .substring(0, 10),
                                  judul: _newsData[index].title,
                                  deskripsi: _newsData[index].description,
                                ),
                              ),
                            ),
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }
}
