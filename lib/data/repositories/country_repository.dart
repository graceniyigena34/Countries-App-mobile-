import 'package:dio/dio.dart';
import '../models/country_summary.dart';
import '../models/country_details.dart';

class CountryRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://restcountries.com/v3.1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<List<CountrySummary>> getAllCountries() async {
    try {
      final response = await _dio.get('/all?fields=name,flags,population,cca2');
      return (response.data as List)
          .map((json) => CountrySummary.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout. Please check your internet.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection. Please check your network.');
      }
      throw Exception('Failed to load countries. Please try again.');
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }

  Future<List<CountrySummary>> searchCountries(String name) async {
    try {
      final response = await _dio.get('/name/$name?fields=name,flags,population,cca2');
      return (response.data as List)
          .map((json) => CountrySummary.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to search countries: $e');
    }
  }

  Future<CountryDetails> getCountryDetails(String cca2) async {
    try {
      final response = await _dio.get('/alpha/$cca2?fields=name,flags,population,capital,region,subregion,area,timezones');
      return CountryDetails.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load country details: $e');
    }
  }
}
