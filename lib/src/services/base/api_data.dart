class APIData {
  static Uri countries() => Uri.parse(
        "https://restcountries.com/v3.1/region/africa?status=true&fields=name,languages,capital,flags",
      );

  static Uri countryDetail({required String country}) => Uri.parse(
        "https://restcountries.com/v3.1/name/$country",
      );
}
