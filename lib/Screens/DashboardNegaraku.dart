// @dart=2.9
import 'package:Corner/Components/littlecard.dart';
import 'package:Corner/Utils/CountryData.dart';
import 'package:Corner/Utils/CountryList.dart';
import 'package:Corner/Utils/DailyModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeSeriesCases {
  final DateTime time;
  final int cases;
  TimeSeriesCases(this.time, this.cases);
}

class DashboardNegaraku extends StatefulWidget {
  @override
  _DashboardNegarakuState createState() => _DashboardNegarakuState();
}

class _DashboardNegarakuState extends State<DashboardNegaraku>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String url = "https://covid19.mathdro.id/api";
  int _tambahanCases = 0, _tambahanRecovered = 0, _tambahanDeath = 0;
  List<CountryList> _countryList = [];
   CountryList _selectedCountry;
   CountryData _countryData;
  List<DailyModel> _dailyCasesData = [];
  List<TimeSeriesCases> _chartTimeSeriesData = [];
  bool _loading = true;

  Future getCountryList() async {
    String url = "https://api.covid19api.com/countries";
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = jsonDecode(res.body);
    // var countryList = (resBody["countries"]);
    setState(() {
      _countryList = (resBody)
          .map<CountryList>((item) => CountryList.fromJson(item))
          .toList();

      // _selectedCountry = _countryList[0];
    });
  }

  _saveDataSelectedCountry(CountryList data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userSelectedCountry", json.encode(data.toJson()));
  }

  _getUserSelectedCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String simpananData = preferences.getString("userSelectedCountry");
    if (simpananData != null) {
      var newData = json.decode(preferences.getString("userSelectedCountry"));
      CountryList countryList = CountryList.fromJson(newData);
      setState(() {
        _selectedCountry = countryList;
      });
      print("countryDataa = " + newData.toString());
    } else {
      setState(() {
        _selectedCountry = _countryList[0];
      });
    }
  }

  Future getNationData(String kodeNegara) async {
    String url = "https://api.covid19api.com/total/country/" + kodeNegara;
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      List<dynamic> countryData =
          data.map((item) => CountryData.fromJson(item)).toList();
      if (countryData[countryData.length - 1].confirmed != null) {
        setState(() {
          _countryData = countryData.length > 1
              ? countryData[countryData.length - 1]
              : CountryData(confirmed: 0, deaths: 0, recovered: 0);

          countryData.length > 1
              ? {
                  _tambahanCases =
                      countryData[countryData.length - 1].confirmed -
                          countryData[countryData.length - 2].confirmed,
                  _tambahanDeath = countryData[countryData.length - 1].deaths -
                      countryData[countryData.length - 2].deaths,
                  _tambahanRecovered =
                      countryData[countryData.length - 1].recovered -
                          countryData[countryData.length - 2].recovered,
                }
              : {
                  _tambahanCases = 0,
                  _tambahanDeath = 0,
                  _tambahanRecovered = 0
                };
        });
      }
    } else {
      print(response.statusCode);
    }
  }

  void _inputChartData() {
    for (var i = _dailyCasesData.length - 7;
        i < _dailyCasesData.length - 1;
        i++) {
      _chartTimeSeriesData.add(TimeSeriesCases(
          DateTime.parse(_dailyCasesData[i].reportDate),
          _dailyCasesData[i].confirmed.total));
    }
  }

  String currencer(data) {
    var currencer = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol:
          '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(data);
    return currencer;
  }

  Future _refreshData() async {
    // await Future.delayed(Duration(seconds: 2));

    await _getUserSelectedCountry();
    await getCountryList();
    await getNationData(_selectedCountry.slug);
    // await this._getDailyData();
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
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: _loading == true
              ? Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 2,
                  child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[],
                ),
        ),
      ),
    );
  }

  Widget timeSeriesChart() {
    var series = [
      new charts.Series(
          id: "Kasus Harian",
          data: _chartTimeSeriesData,
          domainFn: (TimeSeriesCases coinsPrice, _) => coinsPrice.time,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          // domainA
          // grid.
          measureFn: (TimeSeriesCases coinsPrice, _) => coinsPrice.cases)
    ];

    return charts.TimeSeriesChart(
      series,
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      defaultInteractions: false,
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
      animate: false,
    );
  }
}
