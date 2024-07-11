import "package:flutter/material.dart";
import "package:shalom_zen/auth/signin.dart";
import "package:shalom_zen/auth/signup.dart";
import "package:shalom_zen/home/home_screen.dart";
import "package:shalom_zen/onboarding/onboarding.dart";
import "package:shalom_zen/splash/splash_screen.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ShalomZen());
}

class ShalomZen extends StatefulWidget {
  const ShalomZen({super.key});

  @override
  State<ShalomZen> createState() => _ShalomZenState();
}

class _ShalomZenState extends State<ShalomZen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/onboarding": (context) => const OnboardingScreen(),
        "/signup": (context) => const SignUpScreen(),
        "/signin": (context) => const SignInScreen(),
        "/home_screen": (context) => const HomeScreen(),
      },
      theme: ThemeData(
          fontFamily: "Aeonik",
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 61)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)))),
                  textStyle: WidgetStatePropertyAll(
                      TextStyle(fontSize: 24, fontWeight: FontWeight.w400)),
                  backgroundColor: WidgetStatePropertyAll(Color(0xFFD7F7A2))))),
      home: const SplashScreen(),
    );
  }
}
