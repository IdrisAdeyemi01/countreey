import 'package:countreey/src/services/base/api_data.dart';
import 'package:countreey/src/services/network_service/http_network_service_impl.dart';
import 'package:countreey/src/services/network_service/network_service.dart';
import 'package:http/http.dart';

class CountryProvider {
  CountryProvider({NetworkService? networkService})
      : _networkService = networkService ?? HttpServiceImpl(client: Client());

  late final NetworkService _networkService;

  Future<dynamic> fetchCountries() {
    return _networkService.get(APIData.countries());
  }

  Future<dynamic> fetchCountryDetail({required String country}) {
    return _networkService.get(APIData.countryDetail(country: country));
  }
}
