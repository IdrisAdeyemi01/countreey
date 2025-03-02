part of "country_bloc.dart";

enum CountryFetchStatus {
  initial,
  loadingCountries,
  loadingCountryDetails,
  success,
  error,
}

class CountryState extends Equatable {
  const CountryState({
    this.countries = const [],
    this.countryDetail,
    this.status = CountryFetchStatus.initial,
    this.errorMessage = "",
  });

  final List<Country> countries;
  final CountryDetail? countryDetail;
  final CountryFetchStatus status;
  final String errorMessage;

  CountryState copyWith({
    List<Country>? countries,
    CountryDetail? countryDetail,
    CountryFetchStatus? status,
    String? errorMessage,
  }) {
    return CountryState(
      countries: countries ?? this.countries,
      countryDetail: countryDetail ?? this.countryDetail,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        countries,
        status,
        errorMessage,
      ];
}
