import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Image.asset(
              "assets/shalom_background3.png",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: Gap(10)),
              SizedBox(
                  height: 100,
                  width: 96,
                  child: Image.asset("assets/shalom_zen_logo.png")),
              const Gap(220),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Your Personalized \nMeditation Oasis",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
              const Gap(32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/signin",
                        (route) => true,
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: const TextStyle().copyWith(
                        color: const Color(0xFF0D1915),
                      ),
                    )),
              ),
              const Gap(140),
            ],
          )
        ],
      ),
    );
  }
}
