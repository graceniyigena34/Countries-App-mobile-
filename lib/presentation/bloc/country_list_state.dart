import 'package:equatable/equatable.dart';
import '../../data/models/country_summary.dart';

enum SortType { none, nameAsc, nameDesc, populationAsc, populationDesc }

abstract class CountryListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CountryListInitial extends CountryListState {}

class CountryListLoading extends CountryListState {}

class CountryListLoaded extends CountryListState {
  final List<CountrySummary> countries;
  final Set<String> favorites;
  final SortType sortType;

  CountryListLoaded(this.countries, this.favorites, {this.sortType = SortType.none});

  @override
  List<Object?> get props => [countries, favorites, sortType];
}

class CountryListError extends CountryListState {
  final String message;

  CountryListError(this.message);

  @override
  List<Object?> get props => [message];
}
