import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? imgUrl;
    String name = "Silvia Banes";
    return SafeArea(
        child: Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Gap(40),
          imgUrl == null
              ? const CircleAvatar(
                  radius: 58,
                  backgroundColor: Color(0xFFD7F7A2),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xFF0D1915),
                  ),
                )
              : CircleAvatar(
                  radius: 58,
                  backgroundImage: CachedNetworkImageProvider(imgUrl)),
          const Gap(24),
          Text(
            name,
            style: const TextStyle(
                fontFamily: "Aeonik",
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          const Gap(24),
          const ListTile(
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            tileColor: Color(0xFFD7F7A2),
            title: Text(
              "Personal Details",
              style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D1915)),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
          const Gap(8),
          const ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            tileColor: Color(0xFFD7F7A2),
            title: Text(
              "Change Password",
              style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D1915)),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
          const Gap(8),
          const ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            tileColor: Color(0xFFD7F7A2),
            title: Text(
              "Log Out",
              style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D1915)),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
          const Gap(8),
          const ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            tileColor: Color(0xFFD7F7A2),
            title: Text(
              "Delete Account",
              style: TextStyle(
                  fontFamily: "Urbanist",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D1915)),
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    ));
  }
}
