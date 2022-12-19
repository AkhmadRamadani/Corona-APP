// @dart=2.9
import 'package:Corner/Components/littlecard.dart';
import 'package:Corner/Components/text_input.dart';
import 'package:Corner/Utils/CountryData.dart';
import 'package:Corner/Utils/CountryList.dart';
import 'package:Corner/Utils/DailyModel.dart';
import 'package:Corner/Utils/GlobalTotal.dart';
import 'package:Corner/Utils/SummaryModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String url = "https://covid19.mathdro.id/api";
  List<CountryList> _countryList = [];
  List<CountryList> _searchResult = [];
  final String _searchText = "";
  CountryList _selectedCountry;
  List<GlobalTotal> _globalTotal = [];
  final List<DailyModel> _dailyCasesData = [];
  List<TimeSeriesCases> _chartTimeSeriesDataCases = [];
  List<TimeSeriesCases> _chartTimeSeriesDataRecovered = [];
  List<TimeSeriesCases> _chartTimeSeriesDataDeaths = [];
  List data = [];
  RentangWaktu selectedWaktu;
  List<RentangWaktu> rentangWaktu = <RentangWaktu>[
    const RentangWaktu(7, 'Grafik 1 Minggu Terakhir'),
    const RentangWaktu(30, 'Grafik 1 Bulan Terakhir'),
    const RentangWaktu(365, 'Grafik 1 Tahun Terakhir'),
  ];
  Global globalSummary;
  int _tambahanCases = 0, _tambahanRecovered = 0, _tambahanDeath = 0;
  CountryData _countryData;
  TextEditingController myController = TextEditingController();

  StreamController<List<CountryList>> userController =
      StreamController<List<CountryList>>.broadcast();
  bool _loading = true;

  Future getSummary() async {
    String url = "https://api.covid19api.com/summary";
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final resBody = json.decode(response.body);
      SummaryModel summaryModel = SummaryModel.fromJson(resBody);
      setState(() {
        globalSummary = summaryModel.global;
      });
    } else {
      print(response.statusCode);
    }
  }

  Future getChartData() async {
    var now = DateTime.now();
    var sevenDayAgo = new DateTime(2020, 01, 01);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String url = "https://api.covid19api.com/world";
    print(url);
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var resBody = jsonDecode(response.body);
      setState(() {
        _chartTimeSeriesDataCases = [];
        _chartTimeSeriesDataRecovered = [];
        _chartTimeSeriesDataDeaths = [];
      });
      _globalTotal = (resBody)
          .map<GlobalTotal>((item) => GlobalTotal.fromJson(item))
          .toList();
    } else {
      print(response.statusCode);
    }
    _inputChartData(selectedWaktu.id);
  }

  _inputChartData(int kurangi) {
    var dateNow = DateTime.now();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    for (var i = kurangi == 365 ? 0 : _globalTotal.length - kurangi, b = 0;
        i < _globalTotal.length - 1;
        i++, b++) {
      _chartTimeSeriesDataCases.add(TimeSeriesCases(
          DateTime(dateNow.year, dateNow.month, dateNow.day - b),
          _globalTotal[i].newConfirmed));
      _chartTimeSeriesDataRecovered.add(TimeSeriesCases(
          DateTime(dateNow.year, dateNow.month, dateNow.day - b),
          _globalTotal[i].newRecovered));
      _chartTimeSeriesDataDeaths.add(TimeSeriesCases(
          DateTime(dateNow.year, dateNow.month, dateNow.day - b),
          _globalTotal[i].newDeaths));
    }
    // print(_chartTimeSeriesDataCases[0].cases);
    print(dateNow.toString());
  }

  String currencer(data) {
    var currencer = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
    ).format(data);
    return currencer;
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
      int index =
          _countryList.indexWhere((item) => item.country == 'Indonesia');
      setState(() {
        _selectedCountry = _countryList[index];
      });
      // setState(() {
      //   _selectedCountry = _countryList[176];
      // });
    }
  }

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
      userController.sink.add(_countryList);
      _searchResult = _countryList;
      // _selectedCountry = _countryList[0];
    });
    // print(userController.toString());
  }

  Future getNationData(String kodeNegara) async {
    String url = "https://api.covid19api.com/total/country/$kodeNegara";
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
      print("getNationData");
      print('${countryData[countryData.length - 1].confirmed}');
      print('${countryData[countryData.length - 2].confirmed}');
    } else {
      print(response.statusCode);
    }
  }

  _saveDataSelectedCountry(CountryList data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userSelectedCountry", json.encode(data.toJson()));
    print("SaveDataa");
  }

  _filteringCountry(String value) {
    setState(() {
      _searchResult = [];
    });
    // userController.sink.add(null);

    print('total users = ${_countryList.length}');
    if (value.isEmpty) {
      userController.sink.add(_countryList);
      return;
    }
    _countryList.forEach((countryList) {
      if (countryList.country.toLowerCase().contains(value.toLowerCase()))
        _searchResult.add(countryList);
    });

    print(value);
    userController.sink.add(_searchResult);
    // setState(() {});
  }

  Future _refreshData() async {
    // await Future.delayed(Duration(seconds: 2));

    await getCountryList();
    await _getUserSelectedCountry();

    await getNationData(_selectedCountry.slug);
    await getSummary();
    await getChartData();
    setState(() {
      _loading = false;
    });
  }

  @override
  initState() {
    super.initState();
    selectedWaktu = rentangWaktu[0];
    // myController.addListener(_filteringCountry());
    _refreshData();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   userController.close();
  // }

  // Stream<List<CountryList>> get onChangedCountryData => userController.stream;

  Widget getData() {
    return StreamBuilder(
        stream: userController.stream,
        // initialData: ,
        builder:
            (BuildContext context, AsyncSnapshot<List<CountryList>> snapshot) {
          if (snapshot == null) {
            Center(child: CircularProgressIndicator());
            print(snapshot);
          }
          // print(snapshot.data.toList().toString());

          // return snapshot.data == null
          //     ? Center(child: CircularProgressIndicator())
          //     : _newCountryList(snapshot: snapshot);

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _newCountryList(snapshot: _countryList);
              break;
            default:
              return _newCountryList(snapshot: snapshot.data);
          }
          // return snapshot.connectionState == ConnectionState.waiting
          //     ? Center(child: CircularProgressIndicator())
          //     : _newCountryList(snapshot: snapshot);
        });
  }

  Widget _newCountryList({List<CountryList> snapshot}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: snapshot.length,
        itemBuilder: (context, index) => snapshot[index].iso2 != null
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _selectedCountry = snapshot[index];
                  });
                  myController.text = "";
                  _saveDataSelectedCountry(_selectedCountry);

                  getNationData(_selectedCountry.slug);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(""),
                        // child: Image(
                        //     image: NetworkImage("https://www.countryflags.io/" +
                        //         snapshot[index].iso2 +
                        //         "/flat/64.png"),
                        //     width: 50,
                        //     height: 40),
                      ),
                      Expanded(
                        child: Text(
                          snapshot[index].country,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Open Sans"),
                        ),
                        flex: 3,
                      )
                    ],
                    // ),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dasbor"),
      ),
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
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 25.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Pilih Negara",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Open Sans"),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();

                                                myController.text = "";
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: 26,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        margin: EdgeInsets.all(5),
                                        child: TextField(
                                          controller: myController,
                                          onChanged: (value) {
                                            _filteringCountry(value);
                                          },
                                          // onChanged: (item) {
                                          //   _filteringCountry();
                                          // },
                                          decoration: InputDecoration(
                                              // border: InputBorder.none,
                                              hintText: 'Cari'),
                                        ),
                                      ),
                                      Container(child: getData())
                                    ],
                                  )),
                                  elevation: 0.0,
                                ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _selectedCountry.country != null
                                  ? _selectedCountry.country
                                  : "Negara",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Open Sans"),
                            ),
                            flex: 5,
                          ),
                          Expanded(
                            child: Icon(Icons.arrow_drop_down_circle, size: 32),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          LittleCard(
                            label: "Kasus",
                            jumlah: _tambahanCases == 0
                                ? "$_tambahanCases"
                                : currencer(_countryData.confirmed),
                            lebih: _tambahanCases.toString(),
                            type: '',
                          ),
                          LittleCard(
                              label: "Sembuh",
                              lebih: _tambahanRecovered.toString(),
                              jumlah: _tambahanCases == 0
                                  ? "$_tambahanRecovered"
                                  : currencer(_countryData.recovered),
                              type: "Recovered"),
                          LittleCard(
                              label: "Meninggal",
                              lebih: _tambahanDeath.toString(),
                              jumlah: _tambahanCases == 0
                                  ? "$_tambahanDeath"
                                  : currencer(_countryData.deaths),
                              type: "Death"),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Text("Dunia",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Open Sans")),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          LittleCard(
                            label: "Kasus",
                            jumlah: currencer(globalSummary.totalConfirmed),
                            lebih: globalSummary.newConfirmed.toString(),
                            type: '',
                          ),
                          LittleCard(
                              label: "Sembuh",
                              jumlah: currencer(globalSummary.totalRecovered),
                              lebih: globalSummary.newRecovered.toString(),
                              type: "Recovered"),
                          LittleCard(
                              label: "Meninggal",
                              jumlah: currencer(globalSummary.totalDeaths),
                              lebih: globalSummary.newDeaths.toString(),
                              type: "Death"),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical:
                                          MediaQuery.of(context).size.width /
                                              2.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "Pilih Rentang Waktu",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "Open Sans"),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 26,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ))),
                                      Expanded(
                                        child: ListView.separated(
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(),
                                          itemCount: rentangWaktu.length,
                                          itemBuilder: (context, index) =>
                                              rentangWaktu[index].id != null
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() {
                                                          selectedWaktu =
                                                              rentangWaktu[
                                                                  index];

                                                          _chartTimeSeriesDataCases =
                                                              [];
                                                          _chartTimeSeriesDataRecovered =
                                                              [];
                                                          _chartTimeSeriesDataDeaths =
                                                              [];
                                                        });
                                                        _inputChartData(
                                                            rentangWaktu[index]
                                                                .id);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5),
                                                        child: Text(
                                                          rentangWaktu[index]
                                                              .deskripsi,
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Open Sans"),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                        ),
                                      )
                                    ],
                                  )),
                                  elevation: 0.0,
                                ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              selectedWaktu.deskripsi != null
                                  ? selectedWaktu.deskripsi
                                  : "Waktu",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Open Sans"),
                            ),
                            flex: 5,
                          ),
                          Expanded(
                            child: Icon(Icons.arrow_drop_down_circle, size: 32),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: SizedBox(
                        height: 200,
                        child: timeSeriesChart(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text("Diagram Pie Covid-19",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Open Sans")),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 200,
                                child: pieChart(),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 20,
                                          margin: EdgeInsets.all(5),
                                          height: 20,
                                          color: Colors.blueAccent,
                                        ),
                                        Flexible(
                                          child: Text("Jumlah Kasus",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueAccent,
                                                  fontFamily: "Roboto")),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 20,
                                          margin: EdgeInsets.all(5),
                                          height: 20,
                                          color: Colors.green,
                                        ),
                                        Flexible(
                                          child: Text("Jumlah Sembuh",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  fontFamily: "Roboto")),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 20,
                                          margin: EdgeInsets.all(5),
                                          height: 20,
                                          color: Colors.redAccent,
                                        ),
                                        Flexible(
                                          child: Text("Jumlah Kematian",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent,
                                                  fontFamily: "Roboto")),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),

                    // ListView.separated(
                    //   itemBuilder: (context, index) => Container,
                    //   separatorBuilder: null,
                    //   itemCount: null)
                  ],
                ),
        ),
      ),
    );
  }

  Widget timeSeriesChart() {
    // final data = [
    //   new TimeSeriesCases("Kasus", _worldCases),
    //   new TimeSeriesCases("Sembuh", _worldRecovered),
    //   new TimeSeriesCases("Meninggal", _worldDeath)
    // ];

    var series = [
      new charts.Series<TimeSeriesCases, DateTime>(
          id: "Kasus",
          data: _chartTimeSeriesDataCases,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (TimeSeriesCases coinsPrice, _) => coinsPrice.time,
          measureFn: (TimeSeriesCases coinsPrice, _) => coinsPrice.cases),
      new charts.Series<TimeSeriesCases, DateTime>(
          id: "Sembuh",
          data: _chartTimeSeriesDataRecovered,
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesCases coinsPrice, _) => coinsPrice.time,
          measureFn: (TimeSeriesCases coinsPrice, _) => coinsPrice.cases),
      new charts.Series<TimeSeriesCases, DateTime>(
          id: "Meninggal",
          data: _chartTimeSeriesDataDeaths,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (TimeSeriesCases coinsPrice, _) => coinsPrice.time,
          measureFn: (TimeSeriesCases coinsPrice, _) => coinsPrice.cases),
    ];

    return charts.TimeSeriesChart(
      series,
      defaultInteractions: false,
      animate: false,

      dateTimeFactory: const charts.LocalDateTimeFactory(),

      // defaultRenderer: new charts.ArcRendererConfig(
      //   arcWidth: 60,
      //   arcRendererDecorators: [new charts.ArcLabelDecorator()],
      // ),
      // selectionModels: [
      //   charts.SelectionModelConfig(
      //     type: charts.SelectionModelType.info,
      //   )
      // ],
    );
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Widget pieChart() {
    var totalData = globalSummary.totalConfirmed +
        globalSummary.totalDeaths +
        globalSummary.totalRecovered;

    final data = [
      new PieChartData(
          "Kasus",
          globalSummary.totalConfirmed,
          roundDouble(globalSummary.totalConfirmed / totalData, 3) * 100,
          charts.MaterialPalette.blue.shadeDefault),
      new PieChartData(
          "Sembuh",
          globalSummary.totalRecovered,
          roundDouble(globalSummary.totalRecovered / totalData, 3) * 100,
          charts.MaterialPalette.green.shadeDefault),
      new PieChartData(
          "Meninggal",
          globalSummary.totalDeaths,
          roundDouble(globalSummary.totalDeaths / totalData, 3) * 100,
          charts.MaterialPalette.red.shadeDefault),
    ];

    var series = [
      new charts.Series<PieChartData, String>(
          id: "Kasus",
          data: data,
          domainFn: (PieChartData coinsPrice, _) =>
              coinsPrice.percentage.toString(),
          colorFn: (PieChartData segment, _) => segment.color,
          labelAccessorFn: (PieChartData row, _) => '${row.percentage} %',
          measureFn: (PieChartData coinsPrice, _) => coinsPrice.data),
    ];

    return charts.PieChart(series,
        defaultInteractions: false,
        animate: false,
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }
}

class TimeSeriesCases {
  final DateTime time;
  // final String judul;
  final int cases;
  TimeSeriesCases(this.time, this.cases);
}

class RentangWaktu {
  const RentangWaktu(this.id, this.deskripsi);

  final String deskripsi;
  final int id;
}

class PieChartData {
  final String judul;
  final int data;
  final double percentage;
  final charts.Color color;
  PieChartData(this.judul, this.data, this.percentage, this.color);
}
