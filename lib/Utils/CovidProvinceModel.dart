class CovidProvince {
  CovidProvince({
    required this.lastDate,
    required this.currentData,
    required this.missingData,
    required this.tanpaProvinsi,
    required this.listData,
  });

  final DateTime lastDate;
  final double currentData;
  final double missingData;
  final int tanpaProvinsi;
  final List<Province> listData;

  factory CovidProvince.fromJson(Map<String, dynamic> json) => CovidProvince(
        lastDate: DateTime.parse(json["last_date"]),
        currentData: json["current_data"].toDouble(),
        missingData: json["missing_data"].toDouble(),
        tanpaProvinsi: json["tanpa_provinsi"],
        listData: List<Province>.from(
            json["list_data"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "last_date":
            "${lastDate.year.toString().padLeft(4, '0')}-${lastDate.month.toString().padLeft(2, '0')}-${lastDate.day.toString().padLeft(2, '0')}",
        "current_data": currentData,
        "missing_data": missingData,
        "tanpa_provinsi": tanpaProvinsi,
        "list_data": List<dynamic>.from(listData.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    required this.key,
    required this.docCount,
    required this.jumlahKasus,
    required this.jumlahSembuh,
    required this.jumlahMeninggal,
    required this.jumlahDirawat,
    required this.jenisKelamin,
    required this.kelompokUmur,
    required this.lokasi,
    required this.penambahan,
  });

  String key;
  double docCount;
  int jumlahKasus;
  int jumlahSembuh;
  int jumlahMeninggal;
  int jumlahDirawat;
  List<JenisKelamin> jenisKelamin;
  List<KelompokUmur> kelompokUmur;
  Lokasi lokasi;
  Penambahan penambahan;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        key: json["key"],
        docCount: json["doc_count"].toDouble(),
        jumlahKasus: json["jumlah_kasus"],
        jumlahSembuh: json["jumlah_sembuh"],
        jumlahMeninggal: json["jumlah_meninggal"],
        jumlahDirawat: json["jumlah_dirawat"],
        jenisKelamin: List<JenisKelamin>.from(
            json["jenis_kelamin"].map((x) => JenisKelamin.fromJson(x))),
        kelompokUmur: List<KelompokUmur>.from(
            json["kelompok_umur"].map((x) => KelompokUmur.fromJson(x))),
        lokasi: Lokasi.fromJson(json["lokasi"]),
        penambahan: Penambahan.fromJson(json["penambahan"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "doc_count": docCount,
        "jumlah_kasus": jumlahKasus,
        "jumlah_sembuh": jumlahSembuh,
        "jumlah_meninggal": jumlahMeninggal,
        "jumlah_dirawat": jumlahDirawat,
        "jenis_kelamin":
            List<dynamic>.from(jenisKelamin.map((x) => x.toJson())),
        "kelompok_umur":
            List<dynamic>.from(kelompokUmur.map((x) => x.toJson())),
        "lokasi": lokasi.toJson(),
        "penambahan": penambahan.toJson(),
      };
}

class JenisKelamin {
  JenisKelamin({
    required this.key,
    required this.docCount,
  });

  final String key;
  final int docCount;

  factory JenisKelamin.fromJson(Map<String, dynamic> json) => JenisKelamin(
        key: json["key"],
        docCount: json["doc_count"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "doc_count": docCount,
      };
}

class KelompokUmur {
  KelompokUmur({
    required this.key,
    required this.docCount,
    required this.usia,
  });

  final String key;
  final int docCount;
  final Usia usia;

  factory KelompokUmur.fromJson(Map<String, dynamic> json) => KelompokUmur(
        key: json["key"],
        docCount: json["doc_count"],
        usia: Usia.fromJson(json["usia"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "doc_count": docCount,
        "usia": usia.toJson(),
      };
}

class Usia {
  Usia({
    required this.value,
  });

  final double value;

  factory Usia.fromJson(Map<String, dynamic> json) => Usia(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Lokasi {
  Lokasi({
    required this.lon,
    required this.lat,
  });

  final double lon;
  final double lat;

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

class Penambahan {
  Penambahan({
    required this.positif,
    required this.sembuh,
    required this.meninggal,
  });

  final int positif;
  final int sembuh;
  final int meninggal;

  factory Penambahan.fromJson(Map<String, dynamic> json) => Penambahan(
        positif: json["positif"],
        sembuh: json["sembuh"],
        meninggal: json["meninggal"],
      );

  Map<String, dynamic> toJson() => {
        "positif": positif,
        "sembuh": sembuh,
        "meninggal": meninggal,
      };
}
