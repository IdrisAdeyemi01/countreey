
import 'package:countreey/src/data/models/country.dart';
import 'package:countreey/src/data/models/country_detail.dart';
import 'package:countreey/src/data/providers/country_provider.dart';

class CountryRepository {
  CountryRepository({CountryProvider? countryProvider})
      : _countryProvider = countryProvider ?? CountryProvider();

  final CountryProvider _countryProvider;

  Future<List<Country>> fetchCountries() async {
    try {
      final response = await _countryProvider.fetchCountries();
      return List<Country>.from(response.map((x) => Country.fromJson(x)));
    } catch (_) {
      rethrow;
    }
  }

  Future<CountryDetail> fetchCountryDetail(String countryName) async {
    try {
      final responseData =
          await _countryProvider.fetchCountryDetail(country: countryName);

      final returnCountries = List<CountryDetail>.from(
        responseData.map(
          (detail) => CountryDetail.fromJson(detail),
        ),
      );
      return returnCountries.first;
    } catch (_) {
      rethrow;
    }
  }
}
