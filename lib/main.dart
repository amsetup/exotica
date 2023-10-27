// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:exotica_app/env.dart';
import 'package:exotica_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:exotica_app/utils/app_theme.dart';

void main() {   
  //EnvConfig.envBuild = Env.DEV;
  EnvConfig.envBuild = Env.PROD;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMSetup',
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.splash,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: AppTheme.textTheme
      ),
    );
  }
  
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}