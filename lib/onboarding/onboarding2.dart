import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Image.asset(
                "assets/shalom_background5.png",
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SafeArea(
                child: PageView(
              controller: pageController,
              children: [
                Column(
                  children: [
                    Gap(MediaQuery.of(context).size.height * 0.3),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        "Craft Your Calm: Meditate with Your Voice",
                        style: TextStyle(
                            fontSize: 28, color: Colors.white, wordSpacing: 3),
                      ),
                    ),
                    const Gap(8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        "Shalom Zen unlocks the power of personalized mantras and Hz frequencies for deeper meditation.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const Expanded(child: Gap(10)),
                    SmoothPageIndicator(
                        controller: pageController, // PageController
                        count: 3,
                        effect: const WormEffect(
                            activeDotColor: Colors.white,
                            dotColor: Colors.white60), // your preferred effect
                        onDotClicked: (index) {}),
                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButton(
                          onPressed: () {
                            pageController.nextPage(
                                duration: Durations.long4,
                                curve: Curves.easeIn);
                          },
                          child: Text(
                            "Continue",
                            style: const TextStyle().copyWith(
                              color: const Color(0xFF0D1915),
                            ),
                          )),
                    ),
                    const Gap(30)
                  ],
                ),
                Column(
                  children: [
                    Gap(MediaQuery.of(context).size.height * 0.3),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        "Record your own goals, intentions, or mantras to personalize your meditation.",
                        style: TextStyle(
                            fontSize: 28, color: Colors.white, wordSpacing: 3),
                      ),
                    ),
                    const Expanded(child: Gap(10)),
                    SmoothPageIndicator(
                        controller: pageController, // PageController
                        count: 3,
                        effect: const WormEffect(
                            activeDotColor: Colors.white,
                            dotColor: Colors.white60), // your preferred effect
                        onDotClicked: (index) {}),
                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButton(
                          onPressed: () {
                            pageController.nextPage(
                                duration: Durations.long4,
                                curve: Curves.easeIn);
                          },
                          child: Text(
                            "Continue",
                            style: const TextStyle().copyWith(
                              color: const Color(0xFF0D1915),
                            ),
                          )),
                    ),
                    const Gap(30)
                  ],
                ),
                Column(
                  children: [
                    Gap(MediaQuery.of(context).size.height * 0.3),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        "Choose from pure Hz frequencies known for their calming effects or combine them with soothing melodies.",
                        style: TextStyle(
                            fontSize: 28, color: Colors.white, wordSpacing: 3),
                      ),
                    ),
                    const Expanded(child: Gap(10)),
                    SmoothPageIndicator(
                        controller: pageController, // PageController
                        count: 3,
                        effect: const WormEffect(
                            activeDotColor: Colors.white,
                            dotColor: Colors.white54), // your preferred effect
                        onDotClicked: (index) {}),
                    const Gap(16),
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
                            "Continue",
                            style: const TextStyle().copyWith(
                              color: const Color(0xFF0D1915),
                            ),
                          )),
                    ),
                    const Gap(30),
                  ],
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
