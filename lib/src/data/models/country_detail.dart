// To parse this JSON data, do
//
//     final countryDetail = countryDetailFromJson(jsonString);

import 'dart:convert';

List<CountryDetail> countryDetailFromJson(String str) =>
    List<CountryDetail>.from(
        json.decode(str).map((x) => CountryDetail.fromJson(x)));

String countryDetailToJson(List<CountryDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryDetail {
  final Name name;
  final bool independent;
  final String status;
  final bool unMember;
  final List<String> currencies;
  final Idd idd;
  final List<String> capital;
  final List<String> altSpellings;
  final String region;
  final String subregion;
  final List<String> languages;
  final List latlng;
  final bool landlocked;
  final Flags flags;
  final num area;
  final Maps maps;
  final num population;
  final String fifa;
  final Car car;
  final List<String> timezones;
  final List<String> continents;
  final String startOfWeek;

  CountryDetail({
    required this.name,
    required this.independent,
    required this.status,
    required this.unMember,
    required this.currencies,
    required this.idd,
    required this.capital,
    required this.altSpellings,
    required this.region,
    required this.subregion,
    required this.languages,
    required this.latlng,
    required this.landlocked,
    required this.flags,
    required this.area,
    required this.maps,
    required this.population,
    required this.fifa,
    required this.car,
    required this.continents,
    required this.timezones,
    required this.startOfWeek,
  });

  factory CountryDetail.fromJson(Map<String, dynamic> json) => CountryDetail(
        name: Name.fromJson(json["name"]),
        independent: json["independent"],
        status: json["status"],
        unMember: json["unMember"],
        currencies: json["currencies"] == null
            ? []
            : (json["currencies"] as Map<String, dynamic>)
                .values
                .map<String>((currency) => currency['name'] ?? '')
                .toList(),
        idd: Idd.fromJson(json["idd"]),
        capital: List<String>.from(json["capital"].map((x) => x)),
        altSpellings: List<String>.from(json["altSpellings"].map((x) => x)),
        region: json["region"],
        subregion: json["subregion"],
        latlng: json["latlng"],
        languages: json["languages"] == null
            ? []
            : (json["languages"] as Map<String, dynamic>)
                .values
                .cast<String>()
                .toList(),
        landlocked: json["landlocked"],
        flags: Flags.fromJson(json["flags"]),
        area: json["area"],
        maps: Maps.fromJson(json["maps"]),
        population: json["population"],
        fifa: json["fifa"],
        car: Car.fromJson(json["car"]),
        timezones: List<String>.from(json["timezones"].map((x) => x)),
        continents: List<String>.from(json["continents"].map((x) => x)),
        startOfWeek: json["startOfWeek"],
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "independent": independent,
        "status": status,
        "unMember": unMember,
        // "currencies": currencies.toJson(),
        "idd": idd.toJson(),
        "capital": List<dynamic>.from(capital.map((x) => x)),
        "altSpellings": List<dynamic>.from(altSpellings.map((x) => x)),
        "region": region,
        "subregion": subregion,
        "latlng": List<dynamic>.from(latlng.map((x) => x)),
        "landlocked": landlocked,

        "area": area,
      };
}

class Currencies {
  final Lsl lsl;
  final Lsl zar;

  Currencies({
    required this.lsl,
    required this.zar,
  });

  factory Currencies.fromJson(Map<String, dynamic> json) => Currencies(
        lsl: Lsl.fromJson(json["LSL"]),
        zar: Lsl.fromJson(json["ZAR"]),
      );

  Map<String, dynamic> toJson() => {
        "LSL": lsl.toJson(),
        "ZAR": zar.toJson(),
      };
}

class Lsl {
  final String name;
  final String symbol;

  Lsl({
    required this.name,
    required this.symbol,
  });

  factory Lsl.fromJson(Map<String, dynamic> json) => Lsl(
        name: json["name"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
      };
}

class Car {
  final List<String> signs;
  final String side;

  Car({
    required this.signs,
    required this.side,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        signs: List<String>.from(json["signs"].map((x) => x)),
        side: json["side"],
      );

  Map<String, dynamic> toJson() => {
        "signs": List<dynamic>.from(signs.map((x) => x)),
        "side": side,
      };
}

class CoatOfArms {
  final String png;
  final String svg;

  CoatOfArms({
    required this.png,
    required this.svg,
  });

  factory CoatOfArms.fromJson(Map<String, dynamic> json) => CoatOfArms(
        png: json["png"],
        svg: json["svg"],
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
      };
}

class Flags {
  final String png;
  final String svg;
  final String alt;

  Flags({
    required this.png,
    required this.svg,
    required this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"],
        svg: json["svg"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
        "alt": alt,
      };
}

class Maps {
  final String googleMaps;
  final String openStreetMaps;

  Maps({
    required this.googleMaps,
    required this.openStreetMaps,
  });

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        googleMaps: json["googleMaps"],
        openStreetMaps: json["openStreetMaps"],
      );

  Map<String, dynamic> toJson() => {
        "googleMaps": googleMaps,
        "openStreetMaps": openStreetMaps,
      };
}

class Idd {
  final String root;
  final List<String> suffixes;

  Idd({
    required this.root,
    required this.suffixes,
  });

  factory Idd.fromJson(Map<String, dynamic> json) => Idd(
        root: json["root"],
        suffixes: List<String>.from(json["suffixes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "root": root,
        "suffixes": List<dynamic>.from(suffixes.map((x) => x)),
      };
}

class Languages {
  final String eng;
  final String sot;

  Languages({
    required this.eng,
    required this.sot,
  });

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        eng: json["eng"],
        sot: json["sot"],
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
        "sot": sot,
      };
}

class Name {
  final String common;
  final String official;

  Name({
    required this.common,
    required this.official,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
      };
}
