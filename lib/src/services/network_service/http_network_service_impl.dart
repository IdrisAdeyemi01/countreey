import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../base/failure.dart';
import 'network_service.dart';

class HttpServiceImpl implements NetworkService {
  final Client client;
  HttpServiceImpl({required this.client});
  void _throwOnFail(Response res) {
    if (res.statusCode != HttpStatus.ok) {
      final decodedError = jsonDecode(res.body);
      final errorMessage = decodedError["message"];
      final failure = Failure(errorMessage);
      throw failure;
    }
  }

  @override
  Future<dynamic> get(Uri uri) async {
    try {
      final response = await client.get(uri);

      _throwOnFail(response);

      return jsonDecode(response.body);
    } on SocketException {
      throw Failure('Please check your internet connection 😑');
    } on FormatException {
      throw Failure('Bad response format 👎');
    } on HttpException {
      throw Failure('Please check your internet connection');
    } catch (ex) {
      throw Failure(ex.toString());
    }
  }
}
