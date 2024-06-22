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
      body: homeScreens[0],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: pageIndex,
          onTap: (value) {
            pageIndex = value;
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
    );
  }
}
