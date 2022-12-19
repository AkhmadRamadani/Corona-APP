// @dart=2.9
import 'dart:convert';

String countryListToJson(data) => json.encode(data.toJson());

class CountryList {
  CountryList({
    this.country,
    this.slug,
    this.iso2,
  });

  String country;
  String slug;
  String iso2;

  factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
        country: json["Country"],
        slug: json["Slug"],
        iso2: json["ISO2"],
      );

  Map<String, dynamic> toJson() => {
        "Country": country,
        "Slug": slug,
        "ISO2": iso2,
      };
}
