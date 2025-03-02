import 'package:countreey/src/core/router/routes.dart';
import 'package:countreey/src/data/repositories/country_repository.dart';
import 'package:countreey/src/logic/bloc/country/country_bloc.dart';
import 'package:countreey/src/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final CountryRepository countryRepository = CountryRepository();
  runApp(
    BlocProvider<CountryBloc>(
      create: (context) => CountryBloc(countryRepository: countryRepository),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
