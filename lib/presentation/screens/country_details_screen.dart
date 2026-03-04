import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/country_repository.dart';
import '../bloc/country_details_cubit.dart';
import '../bloc/country_details_state.dart';

class CountryDetailsScreen extends StatelessWidget {
  final String cca2;
  final String countryName;

  const CountryDetailsScreen({
    super.key,
    required this.cca2,
    required this.countryName,
  });

  String _formatNumber(num value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountryDetailsCubit(CountryRepository())..loadCountryDetails(cca2),
      child: Scaffold(
        appBar: AppBar(
          title: Text(countryName),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<CountryDetailsCubit, CountryDetailsState>(
          builder: (context, state) {
            if (state is CountryDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CountryDetailsLoaded) {
              final country = state.country;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      country.flag,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.flag, size: 64),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Key Statistics',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('Capital', country.capital),
                          _buildInfoRow('Region', country.region),
                          _buildInfoRow('Sub Region', country.subregion),
                          _buildInfoRow('Population', _formatNumber(country.population)),
                          _buildInfoRow('Area', '${_formatNumber(country.area)} km²'),
                          const SizedBox(height: 24),
                          const Text(
                            'Timezone',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...country.timezones.map((tz) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(tz),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CountryDetailsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text('Failed to load country details'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CountryDetailsCubit>().loadCountryDetails(cca2);
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
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
