// @dart=2.9
import 'package:Corner/Components/RankingCard.dart';
import 'package:Corner/Utils/SummaryModel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';

class RankingDeath extends StatefulWidget {
  final bool ascending;

  const RankingDeath({Key key,  this.ascending}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RankingDeathState();
}

class RankingDeathState extends State<RankingDeath>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Country> _countryData = [];
  bool _loading = true;

  Future getSummary() async {
    String url = "https://api.covid19api.com/summary";
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final resBody = json.decode(response.body);
      SummaryModel summaryModel = SummaryModel.fromJson(resBody);
      setState(() {
        _countryData = summaryModel.countries;
      });
      sortingDataa(reversed: widget.ascending);
    } else {
      print(response.statusCode);
    }
  }

  void sortingDataa({bool reversed}) {
    Comparator<Country> lister = (a, b) => reversed
        ? a.totalDeaths.compareTo(b.totalDeaths)
        : b.totalDeaths.compareTo(a.totalDeaths);
    _countryData.sort(lister);
    getSummary();
  }

  Future _onRefresh() async {
    await getSummary();
    setState(() {
      _loading = false;
    });
  }

  @override
  initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _loading == true
            ? Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (context, index) => RankingCard(
                  country: _countryData[index].country,
                  iso2: _countryData[index].countryCode,
                  index: index,
                  jumlah: NumberFormat.currency(symbol: '')
                      .format(_countryData[index].totalDeaths),
                  type: "Death",
                ),
                itemCount: _countryData.length,
              ),
      ),
    );
  }
}
