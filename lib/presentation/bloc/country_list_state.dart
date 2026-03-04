import 'package:equatable/equatable.dart';
import '../../data/models/country_summary.dart';

abstract class CountryListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CountryListInitial extends CountryListState {}

class CountryListLoading extends CountryListState {}

class CountryListLoaded extends CountryListState {
  final List<CountrySummary> countries;
  final Set<String> favorites;

  CountryListLoaded(this.countries, this.favorites);

  @override
  List<Object?> get props => [countries, favorites];
}

class CountryListError extends CountryListState {
  final String message;

  CountryListError(this.message);

  @override
  List<Object?> get props => [message];
}
