import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shalom_zen/services/auth/auth_service.dart';
import 'package:shalom_zen/services/database/firebase_cloud_database.dart';
import 'package:shalom_zen/services/storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final deletePasswordController = TextEditingController();
  String email = AuthService.firebase().currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreProvider().getUser(),
        builder: (context, snapshot) {
          String? imgUrl = snapshot.data?.profileUrl;
          String name =
              "${snapshot.data?.firstName ?? ""} ${snapshot.data?.lastName ?? ""}";
          return SafeArea(
              child: Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gap(40),
                  imgUrl == null
                      ? GestureDetector(
                          onTap: () async {
                            try {
                              final ImagePicker picker = ImagePicker();
// Pick an image.
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);

                              if (image != null) {
                                String picUrl = await AppFirebaseStorage()
                                    .uploadFile(File(image.path));
                                FirestoreProvider()
                                    .updateUser(profileUrl: picUrl);
                                setState(() {});
                              }
                            } catch (e) {
                              print(e);
                              Fluttertoast.showToast(
                                  msg: "Something went wrong",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: const CircleAvatar(
                            radius: 58,
                            backgroundColor: Color(0xFFD7F7A2),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Color(0xFF0D1915),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            try {
                              final ImagePicker picker = ImagePicker();
// Pick an image.
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);

                              if (image != null) {
                                String picUrl = await AppFirebaseStorage()
                                    .uploadFile(File(image.path));
                                FirestoreProvider()
                                    .updateUser(profileUrl: picUrl);
                                setState(() {});
                              }
                            } catch (e) {
                              print(e);
                              Fluttertoast.showToast(
                                  msg: "Something went wrong",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: CircleAvatar(
                              radius: 58,
                              backgroundImage:
                                  CachedNetworkImageProvider(imgUrl)),
                        ),
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
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        child: const Icon(
                                          CupertinoIcons.xmark_circle,
                                          size: 38,
                                        ),
                                      )),
                                  const Text("Change first / last name",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w700,
                                        // fontFamily: "Manrope"
                                      )),
                                  const Gap(16),
                                  const Text("Firstname",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        // fontFamily: "Manrope"
                                      )),
                                  const Gap(4),
                                  TextField(
                                    controller: firstNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your firstname',
                                      prefixIcon: Container(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Icon(Icons.person),
                                            const SizedBox(
                                              height: 61,
                                            ),
                                            const Gap(8),
                                            Container(
                                              height: 24.0,
                                              width: 1.0,
                                              color: Colors.grey,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16.0, horizontal: 12.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(13.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                  ),
                                  const Gap(16),
                                  const Text("Lastname",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        // fontFamily: "Manrope"
                                      )),
                                  const Gap(4),
                                  TextField(
                                    controller: lastNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your lastname',
                                      prefixIcon: Container(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Icon(Icons.person),
                                            const SizedBox(
                                              height: 61,
                                            ),
                                            const Gap(8),
                                            Container(
                                              height: 24.0,
                                              width: 1.0,
                                              color: Colors.grey,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16.0, horizontal: 12.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(13.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                  ),
                                  const Gap(24),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await FirestoreProvider()
                                            .updateUser(
                                                firstName:
                                                    firstNameController.text,
                                                lastName:
                                                    lastNameController.text)
                                            .then(
                                          (value) {
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                      child: Text(
                                        "Update",
                                        style: const TextStyle().copyWith(
                                            color: const Color(0xFF0D1915)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    textColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    tileColor: const Color(0xFFD7F7A2),
                    title: const Text(
                      "Personal Details",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D1915)),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  const Gap(8),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        child: const Icon(
                                          CupertinoIcons.xmark_circle,
                                          size: 38,
                                        ),
                                      )),
                                  const Text("Change password",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w700,
                                        // fontFamily: "Manrope"
                                      )),
                                  const Gap(16),
                                  const Text("Current Password",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        // fontFamily: "Manrope"
                                      )),
                                  const Gap(4),
                                  TextField(
                                    controller: currentPasswordController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter current password',
                                      prefixIcon: Container(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Icon(Icons.person),
                                            const SizedBox(
                                              height: 61,
                                            ),
                                            const Gap(8),
                                            Container(
                                              height: 24.0,
                                              width: 1.0,
                                              color: Colors.grey,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16.0, horizontal: 12.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(13.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                  ),
                                  const Gap(16),
                                  const Text("New password",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        // fontFamily: "Manrope"
                                      )),
                                  const Gap(4),
                                  TextField(
                                    controller: newPasswordController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter new password',
                                      prefixIcon: Container(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Icon(Icons.person),
                                            const SizedBox(
                                              height: 61,
                                            ),
                                            const Gap(8),
                                            Container(
                                              height: 24.0,
                                              width: 1.0,
                                              color: Colors.grey,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16.0, horizontal: 12.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(13.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                  ),
                                  const Gap(24),
                                  ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          await AuthService.firebase()
                                              .sendPasswordReset(toEmail: email)
                                              .then(
                                                (value) =>
                                                    Navigator.of(context).pop(),
                                              );
                                        } on FirebaseException catch (e) {
                                          Fluttertoast.showToast(
                                              msg: e.message ??
                                                  "Something went wrong",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      },
                                      child: Text(
                                        "Update",
                                        style: const TextStyle().copyWith(
                                            color: const Color(0xFF0D1915)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    tileColor: const Color(0xFFD7F7A2),
                    title: const Text(
                      "Change Password",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D1915)),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  const Gap(8),
                  ListTile(
                    onTap: () {
                      print(FirebaseAuth.instance.currentUser?.uid);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.26,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: const Icon(
                                        CupertinoIcons.xmark_circle,
                                        size: 38,
                                      ),
                                    )),
                                const Text("Log Out",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700,
                                      // fontFamily: "Manrope"
                                    )),
                                const Gap(16),
                                const Text("Are you sure you want to log out?",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      // fontFamily: "Manrope"
                                    )),
                                const Gap(24),
                                ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await AuthService.firebase()
                                            .logOut()
                                            .then(
                                              (value) => Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                "/signin",
                                                (route) => false,
                                              ),
                                            );
                                      } on FirebaseException catch (e) {
                                        Fluttertoast.showToast(
                                            msg: e.message ??
                                                "Something went wrong",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    },
                                    child: Text(
                                      "Log Out",
                                      style: const TextStyle().copyWith(
                                          color: const Color(0xFF0D1915)),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    tileColor: const Color(0xFFD7F7A2),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D1915)),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  const Gap(8),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.39,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: const Icon(
                                        CupertinoIcons.xmark_circle,
                                        size: 38,
                                      ),
                                    )),
                                const Text("Delete Account",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700,
                                      // fontFamily: "Manrope"
                                    )),
                                const Gap(16),
                                const Text(
                                    "Are you sure you want to delete your account? Enter password to continue",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      // fontFamily: "Manrope"
                                    )),
                                TextField(
                                  controller: deletePasswordController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    prefixIcon: Container(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Icon(Icons.lock),
                                          const SizedBox(
                                            height: 61,
                                          ),
                                          const Gap(8),
                                          Container(
                                            height: 24.0,
                                            width: 1.0,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 12.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                ),
                                const Gap(24),
                                ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await AuthService.firebase()
                                            .logIn(
                                                email: email,
                                                password:
                                                    deletePasswordController
                                                        .text)
                                            .then(
                                              (value) => AuthService.firebase()
                                                  .deleteAccount(),
                                            )
                                            .then(
                                              (value) =>
                                                  Navigator.of(context).pop(),
                                            );
                                      } on FirebaseException catch (e) {
                                        Fluttertoast.showToast(
                                            msg: e.message ??
                                                "Something went wrong",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    },
                                    child: Text(
                                      "Delete",
                                      style: const TextStyle().copyWith(
                                          color: const Color(0xFF0D1915)),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    tileColor: const Color(0xFFD7F7A2),
                    title: const Text(
                      "Delete Account",
                      style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D1915)),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ));
        });
  }
}
