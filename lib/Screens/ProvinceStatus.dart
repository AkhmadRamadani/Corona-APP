import 'dart:convert';

import 'package:Corner/Utils/CovidProvinceModel.dart';
import 'package:Corner/Components/ProvinceCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum ResultState { idle, loading, noData, hasData, erorr }

class ProvinceStatus extends StatefulWidget {
  const ProvinceStatus({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProvinceStatusState();
}

class _ProvinceStatusState extends State<ProvinceStatus> {
  var _resultState = ResultState.loading;
  List<Province> provinceData = [];

  Future getProvinceData() async {
    updateResultState(ResultState.loading);
    String url = "https://data.covid19.go.id/public/api/prov.json";
    http.Response response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final resBody = json.decode(response.body);
      CovidProvince covidProvince = CovidProvince.fromJson(resBody);
      if (covidProvince.listData.isEmpty) {
        updateResultState(ResultState.erorr);
        print("Empty Data");
      } else {
        setState(() {
          _resultState = ResultState.hasData;
          provinceData = covidProvince.listData;
        });
      }
    } else {
      updateResultState(ResultState.erorr);
      print(response.statusCode);
    }
  }

  void updateResultState(ResultState state) {
    setState(() {
      _resultState = state;
    });
  }

  @override
  initState() {
    super.initState();
    getProvinceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Province Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: _resultState == ResultState.loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: provinceData.length,
                itemBuilder: (context, index) {
                  return ProvinceCard(province: provinceData[index]);
                },
              ),
      ),
    );
  }
}
