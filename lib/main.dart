import 'package:flutter/material.dart';
import 'package:pokedex/screens/pokedex.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/providers/pokemon_api_provider.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  background: const Color(0xff262835),
  seedColor: const Color(0xff262835),
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.robotoTextTheme(),
);

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: theme,
      home: const PokedexScreen(),
    );
  }
}
