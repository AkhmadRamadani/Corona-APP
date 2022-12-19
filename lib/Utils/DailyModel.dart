// @dart=2.9
class DailyModel {
  int totalConfirmed;
  int mainlandChina;
  int otherLocations;
  int deltaConfirmed;
  int totalRecovered;
  Confirmed confirmed;
  Confirmed deltaConfirmedDetail;
  Confirmed deaths;
  Confirmed recovered;
  int active;
  int deltaRecovered;
  double incidentRate;
  int peopleTested;
  String reportDate;

  DailyModel({
       this.totalConfirmed,
       this.mainlandChina,
       this.otherLocations,
       this.deltaConfirmed,
       this.totalRecovered,
       this.confirmed,
       this.deltaConfirmedDetail,
       this.deaths,
       this.recovered,
       this.active,
       this.deltaRecovered,
       this.incidentRate,
       this.peopleTested,
       this.reportDate});

  factory DailyModel.fromJson(Map<String, dynamic> parsedJson) {
    return DailyModel(
        active: parsedJson['active'],
        confirmed: Confirmed.fromJson(parsedJson['confirmed']),
        deaths: Confirmed.fromJson(parsedJson['deaths']),
        deltaConfirmed: parsedJson['deltaConfirmed'],
        deltaConfirmedDetail:
            Confirmed.fromJson(parsedJson['deltaConfirmedDetail']),
        deltaRecovered: parsedJson['deltaRecovered'],
        incidentRate: parsedJson['incidentRate'],
        mainlandChina: parsedJson['mainlandChina'],
        otherLocations: parsedJson['otherLocations'],
        peopleTested: parsedJson['peopleTested'],
        recovered: Confirmed.fromJson(parsedJson['recovered']),
        reportDate: parsedJson['reportDate'],
        totalConfirmed: parsedJson["totalConfirmed"],
        totalRecovered: parsedJson['totalRecovered']);
  }
}

class Confirmed {
  int total;
  int china;
  int outsideChina;

  Confirmed({ this.total,  this.china,  this.outsideChina});

  factory Confirmed.fromJson(Map<String, dynamic> json) {
    return Confirmed(
        china: json['china'],
        outsideChina: json['outshideChina'],
        total: json['total']);
  }
}
