// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:countreey/src/core/utilities/utility.dart';
import 'package:countreey/src/data/models/country_detail.dart';
import 'package:countreey/src/logic/bloc/country/country_bloc.dart';
import 'package:countreey/src/services/url_launching/url_launcher_service.dart';
import 'package:countreey/src/views/widgets/detail_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDetailView extends StatefulWidget {
  CountryDetailView({super.key, required this.countryName});
  String countryName;

  @override
  State<CountryDetailView> createState() => _CountryDetailViewState();
}

class _CountryDetailViewState extends State<CountryDetailView> {
  late CountryBloc _countryBloc;

  @override
  void initState() {
    super.initState();
    _countryBloc = BlocProvider.of<CountryBloc>(context);
    _countryBloc.add(FetchCountryDetails(widget.countryName));
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
                  context: context,
                  content: state.errorMessage,
                  type: "error",
                );
              });
            }
            if (state.status == CountryFetchStatus.initial) {
              return Center(
                child: Text("Country Detail"),
              );
            } else if (state.status ==
                CountryFetchStatus.loadingCountryDetails) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == CountryFetchStatus.success &&
                state.countryDetail != null) {
              CountryDetail detail = state.countryDetail!;
              return RefreshIndicator(
                onRefresh: () async {
                  _countryBloc.add(FetchCountryDetails(widget.countryName));
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        width: MediaQuery.sizeOf(context).width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: detail.flags.png,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DetailText(
                        title: "Name",
                        label: detail.name.common,
                      ),
                      DetailText(
                        title: "Capital",
                        label: detail.capital.first,
                      ),
                      DetailText(
                        title: "Region",
                        label: detail.region,
                      ),
                      DetailText(
                        title: "Sub region",
                        label: detail.subregion,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DetailText(
                        title: "Language(s)",
                        label: Utility.listToString(detail.languages),
                      ),
                      DetailText(
                        title: "Area",
                        label: Utility.thousandFormatted(detail.area),
                      ),
                      DetailText(
                        title: "Population",
                        label: Utility.thousandFormatted(detail.population),
                      ),
                      DetailText(
                        title: "Currency",
                        label: Utility.listToString(detail.currencies),
                      ),
                      DetailText(
                        title: "Dial code",
                        label: "${detail.idd.root}${detail.idd.suffixes.first}",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DetailText(
                        title: "Time zone",
                        label: detail.timezones.first,
                      ),
                      DetailText(
                        title: "FIFA Acronym",
                        label: detail.fifa,
                      ),
                      DetailText(
                        title: "Car driving side",
                        label: Utility.capitalizeFirst(detail.car.side),
                      ),
                      Row(
                        children: [
                          Text(
                            "Map:   ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              UrlauncherService.launchURL(
                                  detail.maps.googleMaps);
                            },
                            child: Text(
                              "View on Google map",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
              // return CountryListView(countries: state.countries);
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    Text("Country details could not be loaded"),
                    ElevatedButton(
                      child: Text("Refresh"),
                      onPressed: () {
                        _countryBloc
                            .add(FetchCountryDetails(widget.countryName));
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
