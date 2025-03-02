import 'package:bloc/bloc.dart';
import 'package:countreey/src/data/models/country.dart';
import 'package:countreey/src/data/models/country_detail.dart';
import 'package:countreey/src/data/repositories/country_repository.dart';
import 'package:countreey/src/services/base/failure.dart';
import 'package:equatable/equatable.dart';

part "country_event.dart";
part "country_state.dart";

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository countryRepository;

  List<Country>? _cachedCountries;

  CountryBloc({required this.countryRepository}) : super(CountryState()) {
    on<FetchCountries>(_onFetchCountries);
    on<FetchCountryDetails>(_onFetchCountryDetails);
  }

  Future<void> _onFetchCountries(
    FetchCountries event,
    Emitter<CountryState> emit,
  ) async {
    if (_cachedCountries != null) {
      emit(state.copyWith(
        countries: _cachedCountries!,
        status: CountryFetchStatus.success,
      ));
      return;
    }

    emit(state.copyWith(status: CountryFetchStatus.loadingCountries));
    try {
      final countries = await countryRepository.fetchCountries();
      _cachedCountries = countries;
      emit(state.copyWith(
        countries: countries,
        status: CountryFetchStatus.success,
      ));
    } on Failure catch (failure) {
      emit(state.copyWith(
        errorMessage: failure.message,
        status: CountryFetchStatus.error,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to fetch countries',
          status: CountryFetchStatus.error,
        ),
      );
    } finally {
      state.copyWith(
        errorMessage: "",
        status: CountryFetchStatus.initial,
      );
    }
  }

  Future<void> _onFetchCountryDetails(
      FetchCountryDetails event, Emitter<CountryState> emit) async {
    emit(state.copyWith(
      status: CountryFetchStatus.loadingCountryDetails,
    ));
    try {
      final countryDetails =
          await countryRepository.fetchCountryDetail(event.countryName);

      emit(state.copyWith(
        countryDetail: countryDetails,
        status: CountryFetchStatus.success,
      ));
    } on Failure catch (failure) {
      emit(state.copyWith(
        errorMessage: failure.message,
        status: CountryFetchStatus.error,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to fetch country details',
        status: CountryFetchStatus.error,
      ));
    } finally {
      state.copyWith(errorMessage: "", status: CountryFetchStatus.initial);
    }
  }
}
