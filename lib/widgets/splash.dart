import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:exotica_app/pages/login/login.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
            backgroundColor: Colors.white,
            childWidget: SizedBox(
              height: 250,
              child: Image.asset("assets/images/amsetup.png"),
            ),
            duration: const Duration(milliseconds: 2300),
            animationDuration: const Duration(milliseconds: 1500),
            defaultNextScreen: const LoginScreen(),
      );
  }
}