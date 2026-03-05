import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/country_list_cubit.dart';
import '../bloc/country_list_state.dart';
import 'country_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<CountryListCubit, CountryListState>(
        builder: (context, state) {
          if (state is CountryListLoaded) {
            final favoriteCountries = state.countries
                .where((c) => state.favorites.contains(c.cca2))
                .toList();

            if (favoriteCountries.isEmpty) {
              return const Center(
                child: Text('No favorite countries yet.'),
              );
            }

            return ListView.builder(
              itemCount: favoriteCountries.length,
              itemBuilder: (context, index) {
                final country = favoriteCountries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CountryDetailsScreen(
                            cca2: country.cca2,
                            countryName: country.name,
                          ),
                        ),
                      );
                    },
                    leading: Hero(
                      tag: 'flag_${country.cca2}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          country.flag,
                          width: 60,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 60,
                            height: 40,
                            color: Colors.grey[300],
                            child: const Icon(Icons.flag),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      country.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Population: ${country.population}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        context.read<CountryListCubit>().toggleFavorite(country.cca2);
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
