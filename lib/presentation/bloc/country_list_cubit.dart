import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/country_repository.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../data/models/country_summary.dart';
import 'country_list_state.dart';

class CountryListCubit extends Cubit<CountryListState> {
  final CountryRepository countryRepository;
  final FavoritesRepository favoritesRepository;
  List<CountrySummary> _allCountries = [];

  CountryListCubit(this.countryRepository, this.favoritesRepository) 
      : super(CountryListInitial());

  Future<void> loadCountries() async {
    emit(CountryListLoading());
    try {
      _allCountries = await countryRepository.getAllCountries();
      final favorites = await favoritesRepository.getFavorites();
      emit(CountryListLoaded(_allCountries, favorites));
    } catch (e) {
      emit(CountryListError(e.toString()));
    }
  }

  Future<void> searchCountries(String query) async {
    if (query.isEmpty) {
      await loadCountries();
      return;
    }
    
    emit(CountryListLoading());
    try {
      final countries = await countryRepository.searchCountries(query);
      final favorites = await favoritesRepository.getFavorites();
      emit(CountryListLoaded(countries, favorites));
    } catch (e) {
      emit(CountryListLoaded([], await favoritesRepository.getFavorites()));
    }
  }

  Future<void> toggleFavorite(String cca2) async {
    final currentState = state;
    if (currentState is CountryListLoaded) {
      final isFav = currentState.favorites.contains(cca2);
      if (isFav) {
        await favoritesRepository.removeFavorite(cca2);
      } else {
        await favoritesRepository.addFavorite(cca2);
      }
      final favorites = await favoritesRepository.getFavorites();
      emit(CountryListLoaded(currentState.countries, favorites, sortType: currentState.sortType));
    }
  }

  void sortCountries(SortType sortType) {
    final currentState = state;
    if (currentState is CountryListLoaded) {
      final sorted = List<CountrySummary>.from(currentState.countries);
      switch (sortType) {
        case SortType.nameAsc:
          sorted.sort((a, b) => a.name.compareTo(b.name));
          break;
        case SortType.nameDesc:
          sorted.sort((a, b) => b.name.compareTo(a.name));
          break;
        case SortType.populationAsc:
          sorted.sort((a, b) => a.population.compareTo(b.population));
          break;
        case SortType.populationDesc:
          sorted.sort((a, b) => b.population.compareTo(a.population));
          break;
        case SortType.none:
          break;
      }
      emit(CountryListLoaded(sorted, currentState.favorites, sortType: sortType));
    }
  }
}
