import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:gap/gap.dart';
import 'package:shalom_zen/services/auth/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool hidePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(40),
                    const Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
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
                            padding: const EdgeInsets.only(
                                left:
                                    12.0), // Adds some padding to the left of the icon
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Icon(Icons.email),
                                const Gap(8),
                                Container(
                                  height: 24.0, // Adjust height as needed
                                  width: 1.0, // Width of the divider
                                  color: Colors.grey, // Color of the divider
                                  margin: const EdgeInsets.symmetric(
                                      horizontal:
                                          8.0), // Adds padding around the divider
                                ),
                              ],
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 12.0), // Decent padding
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                13.0), // Border radius of 13
                            borderSide: BorderSide.none, // No border side
                          ),
                          filled: true, // If you want a background color
                          fillColor: Colors.grey[200], // Background color
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
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: '********',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: GestureDetector(
                                onTap: () => setState(() {
                                      hidePassword = !hidePassword;
                                    }),
                                child:
                                    const Icon(Icons.remove_red_eye_outlined)),
                          ),
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                                left:
                                    12.0), // Adds some padding to the left of the icon
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Icon(Icons.lock),
                                const Gap(8),
                                const SizedBox(
                                  height: 61,
                                ),
                                Container(
                                  height: 24.0, // Adjust height as needed
                                  width: 1.0, // Width of the divider
                                  color: Colors.grey, // Color of the divider
                                  margin: const EdgeInsets.symmetric(
                                      horizontal:
                                          8.0), // Adds padding around the divider
                                ),
                              ],
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 12.0), // Decent padding
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                13.0), // Border radius of 13
                            borderSide: BorderSide.none, // No border side
                          ),
                          filled: true, // If you want a background color
                          fillColor: Colors.grey[200], // Background color
                        ),
                      ),
                    ),
                    const Gap(32),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await AuthService.firebase()
                                .logIn(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                                .then((value) {
                              if (value != null) {
                                // Check if login was successful
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/home_screen",
                                  (route) => false,
                                );
                              }
                            });
                          } catch (e) {
                            Fluttertoast.showToast(
                              msg: "Login failed: ${e.toString()}",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: const TextStyle()
                              .copyWith(color: const Color(0xFF0D1915)),
                        )),
                    const Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account?",
                          style: TextStyle(color: Colors.white54, fontSize: 15),
                        ),
                        const Gap(4),
                        GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, "/signup");
                          },
                          child: const Text(
                            "Sign Up",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 15),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
