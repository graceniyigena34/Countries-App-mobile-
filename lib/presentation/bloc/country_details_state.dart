import 'package:equatable/equatable.dart';
import '../../data/models/country_details.dart';

abstract class CountryDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CountryDetailsInitial extends CountryDetailsState {}

class CountryDetailsLoading extends CountryDetailsState {}

class CountryDetailsLoaded extends CountryDetailsState {
  final CountryDetails country;

  CountryDetailsLoaded(this.country);

  @override
  List<Object?> get props => [country];
}

class CountryDetailsError extends CountryDetailsState {
  final String message;

  CountryDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
