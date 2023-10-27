import 'package:exotica_app/pages/produtos/produtos.dart';
import 'package:flutter/material.dart';
import 'package:exotica_app/pages/login/login.dart';
import 'package:exotica_app/pages/home/home.dart';
import 'package:exotica_app/widgets/splash.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String produtos = '/produtos';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const Splash());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case produtos:
        return MaterialPageRoute(builder: (_) => const ProdutosScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}