part of "country_bloc.dart";

abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class FetchCountries extends CountryEvent {}

class FetchCountryDetails extends CountryEvent {
  final String countryName;

  const FetchCountryDetails(this.countryName);

  @override
  List<Object> get props => [countryName];
}
