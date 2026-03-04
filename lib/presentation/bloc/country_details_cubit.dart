import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/country_repository.dart';
import 'country_details_state.dart';

class CountryDetailsCubit extends Cubit<CountryDetailsState> {
  final CountryRepository countryRepository;

  CountryDetailsCubit(this.countryRepository) : super(CountryDetailsInitial());

  Future<void> loadCountryDetails(String cca2) async {
    emit(CountryDetailsLoading());
    try {
      final country = await countryRepository.getCountryDetails(cca2);
      emit(CountryDetailsLoaded(country));
    } catch (e) {
      emit(CountryDetailsError(e.toString()));
    }
  }
}
