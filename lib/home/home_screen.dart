import 'package:flutter/material.dart';
import 'package:shalom_zen/home/home_page.dart';
import 'package:shalom_zen/home/profile_page.dart';
import 'package:shalom_zen/home/sound_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> homeScreens = [
      const HomePage(),
      const SoundPage(),
      const ProfilePage(),
    ];
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Image.asset(
                "assets/shalom_background4.png",
                fit: BoxFit.fill,
              )),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: homeScreens[pageIndex],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: BottomNavigationBar(
                  selectedIconTheme: IconThemeData(size: 32),
                  type: BottomNavigationBarType.fixed,
                  fixedColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.15),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: pageIndex,
                  onTap: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/shalom_zen_logo.png")),
                      label: "HomePage",
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/sounds.png")),
                      label: "SoundPage",
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/user.png")),
                      label: "ProfilePage",
                    ),
                  ]),
            ),
          ),
        ],
      ),
      // bottomNavigationBar:
    );
  }
}
