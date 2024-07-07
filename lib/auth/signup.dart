import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:gap/gap.dart';
import 'package:shalom_zen/services/auth/auth_service.dart';
import 'package:shalom_zen/services/database/firebase_cloud_database.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> signUpForm = GlobalKey();
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: signUpForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(40),
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const Gap(20),
                      const Text(
                        "First Name",
                        style: TextStyle(color: Colors.white54, fontSize: 15),
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 61,
                        child: TextFormField(
                          controller: firstNameController,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Icon(Icons.person),
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
                      ),
                      const Gap(20),
                      const Text(
                        "Last Name",
                        style: TextStyle(color: Colors.white54, fontSize: 15),
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 61,
                        child: TextFormField(
                          controller: lastNameController,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Icon(Icons.person),
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
                      ),
                      const Gap(20),
                      const Text(
                        "Email",
                        style: TextStyle(color: Colors.white54, fontSize: 15),
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 61,
                        child: TextFormField(
                          controller: emailController,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'name@gmail.com',
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Icon(Icons.email),
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
                      ),
                      const Gap(20),
                      const Text(
                        "Password",
                        style: TextStyle(color: Colors.white54, fontSize: 15),
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 61,
                        child: TextFormField(
                          controller: passwordController,
                          // expands: true,
                          // maxLines: null,
                          // minLines: null,
                          obscureText: isShowPassword,
                          decoration: InputDecoration(
                            hintText: '********',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isShowPassword = !isShowPassword;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.remove_red_eye_outlined,
                                  )),
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Icon(Icons.lock),
                                  const Gap(8),
                                  const SizedBox(
                                    height: 61,
                                  ),
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
                      ),
                      const Gap(20),
                      const Text(
                        "Confirm Password",
                        style: TextStyle(color: Colors.white54, fontSize: 15),
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 61,
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '********',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isShowConfirmPassword =
                                          !isShowConfirmPassword;
                                    });
                                  },
                                  child: const Icon(
                                      Icons.remove_red_eye_outlined)),
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(left: 12.0),
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
                      ),
                      const Gap(32),
                      ElevatedButton(
                          onPressed: () async {
                            try {
                              if (signUpForm.currentState!.validate()) {
                                if (passwordController.text ==
                                        confirmPasswordController.text &&
                                    passwordController.text.isNotEmpty) {
                                  await AuthService.firebase()
                                      .createUser(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then(
                                        (value) => FirestoreProvider()
                                            .createUser(
                                                email: value.email,
                                                firstName:
                                                    firstNameController.text,
                                                lastName:
                                                    lastNameController.text,
                                                password:
                                                    passwordController.text),
                                      )
                                      .then(
                                        (value) => Navigator.of(context)
                                            .pushNamed("/home_screen"),
                                      );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Passwords do not match",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.teal,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Enter all fields",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.teal,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } on FirebaseException catch (e) {
                              Fluttertoast.showToast(
                                  msg: e.message ?? "Something went wrong",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.teal,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: Text(
                            "Sign Up",
                            style: const TextStyle()
                                .copyWith(color: const Color(0xFF0D1915)),
                          )),
                      const Gap(24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 15),
                          ),
                          const Gap(4),
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, "/signin");
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 15),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
