import 'package:countreey/src/views/country_detail_view.dart';
import 'package:countreey/src/views/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const homeView = '/homeView';
  static const countryDetailView = '/countryDetailView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeView:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case countryDetailView:
        return MaterialPageRoute(
          builder: (_) => CountryDetailView(
            countryName: settings.arguments as String,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
