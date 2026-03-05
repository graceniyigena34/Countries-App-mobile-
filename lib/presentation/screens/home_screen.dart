import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/country_list_cubit.dart';
import '../bloc/country_list_state.dart';
import '../bloc/theme_cubit.dart';
import '../widgets/country_list_item.dart';
import '../widgets/shimmer_loading.dart';
import 'country_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CountryListCubit>().loadCountries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<SortType>(
            icon: const Icon(Icons.sort),
            onSelected: (sortType) => context.read<CountryListCubit>().sortCountries(sortType),
            itemBuilder: (context) => [
              const PopupMenuItem(value: SortType.nameAsc, child: Text('Name (A-Z)')),
              const PopupMenuItem(value: SortType.nameDesc, child: Text('Name (Z-A)')),
              const PopupMenuItem(value: SortType.populationAsc, child: Text('Population (Low-High)')),
              const PopupMenuItem(value: SortType.populationDesc, child: Text('Population (High-Low)')),
            ],
          ),
          IconButton(
            icon: Icon(context.watch<ThemeCubit>().state ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a country',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
              ),
              onChanged: (value) {
                context.read<CountryListCubit>().searchCountries(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<CountryListCubit, CountryListState>(
              builder: (context, state) {
                if (state is CountryListLoading) {
                  return const ShimmerLoading();
                } else if (state is CountryListLoaded) {
                  if (state.countries.isEmpty) {
                    return const Center(
                      child: Text('No countries found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.countries.length,
                    itemBuilder: (context, index) {
                      final country = state.countries[index];
                      return CountryListItem(
                        country: country,
                        isFavorite: state.favorites.contains(country.cca2),
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
                        onFavoriteToggle: () {
                          context.read<CountryListCubit>().toggleFavorite(country.cca2);
                        },
                      );
                    },
                  );
                } else if (state is CountryListError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        const Text('Failed to load countries'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CountryListCubit>().loadCountries();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
