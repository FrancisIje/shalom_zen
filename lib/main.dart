import "package:flutter/material.dart";
import "package:shalom_zen/onboarding/onboarding.dart";
import "package:shalom_zen/splash/splash_screen.dart";

void main() {
  runApp(ShalomZen());
}

class ShalomZen extends StatelessWidget {
  const ShalomZen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/onboarding": (context) => const OnboardingScreen(),
      },
      theme: ThemeData(
          fontFamily: "Aeonik",
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)))),
                  textStyle: WidgetStatePropertyAll(
                      TextStyle(color: Color(0xFF0D1915))),
                  backgroundColor: WidgetStatePropertyAll(Color(0xFFD7F7A2))))),
      home: SplashScreen(),
    );
  }
}
