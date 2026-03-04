import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepository {
  static const String _key = 'favorite_countries';

  Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key)?.toSet() ?? {};
  }

  Future<void> addFavorite(String cca2) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key)?.toSet() ?? {};
    favorites.add(cca2);
    await prefs.setStringList(_key, favorites.toList());
  }

  Future<void> removeFavorite(String cca2) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key)?.toSet() ?? {};
    favorites.remove(cca2);
    await prefs.setStringList(_key, favorites.toList());
  }

  Future<bool> isFavorite(String cca2) async {
    final favorites = await getFavorites();
    return favorites.contains(cca2);
  }
}
