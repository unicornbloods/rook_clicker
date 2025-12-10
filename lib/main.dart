import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rook_clicker/core/theme/main_theme.dart';
import 'package:rook_clicker/presentation/features/main_game/view/main_game_screen.dart';
import 'package:rook_clicker/presentation/features/main_game/viewmodel/main_game_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainGameViewmodel(),
      child: const RookClicker(),
    ),
  );
}

class RookClicker extends StatelessWidget {
  const RookClicker({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.teal,
  );
  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HTML parsing test',
      // theme: MyThemeData.themeData(_defaultLightColorScheme),
      // darkTheme: MyThemeData.themeData(_defaultDarkColorScheme),
      // I only want dark mode for now
      theme: MyThemeData.themeData(_defaultDarkColorScheme),
      darkTheme: MyThemeData.themeData(_defaultDarkColorScheme),
      home: const MainGameScreen(),
    );
  }
}
