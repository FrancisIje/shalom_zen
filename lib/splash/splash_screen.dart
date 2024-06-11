import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return FlutterSplashScreen.fadeIn(
      asyncNavigationCallback: () async {
        await Future.delayed(const Duration(seconds: 3));
        // Navigator.of(context).popAndPushNamed("/onboarding");
      },
      backgroundImage: Image.asset("assets/shalom_background2.png"),

      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: screenSize.height * 0.68,
        width: double.maxFinite,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Gap(screenSize.height * 0.3),
            SizedBox(
                height: 100,
                width: 96,
                child: Image.asset("assets/shalom_zen_logo.png")),
            Expanded(child: const Gap(40)),
            Text(
              "Shalom Zen",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  color: Colors.white),
            )
          ],
        ),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      // nextScreen: ,
    );
  }
}
