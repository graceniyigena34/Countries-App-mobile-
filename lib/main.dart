import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/country_repository.dart';
import 'data/repositories/favorites_repository.dart';
import 'presentation/bloc/country_list_cubit.dart';
import 'presentation/bloc/theme_cubit.dart';
import 'presentation/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CountryListCubit(CountryRepository(), FavoritesRepository())),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDark) {
          return MaterialApp(
            title: 'Countries App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
              useMaterial3: true,
            ),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
