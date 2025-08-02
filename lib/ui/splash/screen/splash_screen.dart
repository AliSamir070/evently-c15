import 'package:evently_c15/core/resources/AssetsManager.dart';
import 'package:evently_c15/core/resources/ColorManager.dart';
import 'package:evently_c15/ui/home/screen/home_screen.dart';
import 'package:evently_c15/ui/login/screen/login_screen.dart';
import 'package:evently_c15/ui/start/screen/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AssetsManager.logo))
          .animate(
        onComplete: (controller) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);

        },
      )
          .fade(duration: Duration(seconds: 2))
          .slideX(duration: Duration(seconds: 2)),
    );
  }
}
