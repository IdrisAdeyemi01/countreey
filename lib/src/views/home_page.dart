import 'package:countreey/src/core/utilities/utility.dart';
import 'package:countreey/src/data/models/country.dart';
import 'package:countreey/src/logic/bloc/country/country_bloc.dart';
import 'package:countreey/src/views/widgets/country_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CountryBloc _countryBloc;

  @override
  void initState() {
    super.initState();

    _countryBloc = BlocProvider.of<CountryBloc>(context);
    _countryBloc.add(FetchCountries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          "Explore Africa",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blue,
            fontFamily: "Pacifico",
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state.status == CountryFetchStatus.error) {
              Future.delayed(Duration(seconds: 2)).then((v) {
                Utility.showSnackBar(
                  // ignore: use_build_context_synchronously
                  context: context,
                  content: state.errorMessage,
                  type: "error",
                );
              });
            }
            if (state.status == CountryFetchStatus.initial) {
              return Center(
                child: Text("Countries List"),
              );
            } else if (state.status == CountryFetchStatus.loadingCountries) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == CountryFetchStatus.success) {
              return CountryListView(countries: state.countries);
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    Text("Countries could not be loaded"),
                    ElevatedButton(
                      child: Text("Refresh"),
                      onPressed: () {
                        _countryBloc.add(FetchCountries());
                      },
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CountryListView extends StatelessWidget {
  const CountryListView({
    super.key,
    required this.countries,
  });

  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppTextfield(),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<CountryBloc>(context).add(FetchCountries());
            },
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                final countryName = country.name.common;
                final countryCapital = country.capital.first;
                final countryFlag = country.flags.png;
                return CountryTile(
                  countryName: countryName,
                  countryCapital: countryCapital,
                  flagUrl: countryFlag,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
