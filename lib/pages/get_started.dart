import 'package:flutter/material.dart';
import 'package:ginie_ai/components/button.dart';
import 'package:ginie_ai/components/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_page.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppConstants.backgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Let's get starget text
              const Spacer(
                flex: 2,
              ),

              const Text("Let's Get Started",
                  style: AppConstants.titleTextStyle),

              //sub text talking about how they can login
              const SizedBox(
                height: 20,
              ),

              const Text(
                textAlign: TextAlign.center,
                "sign in to use ginie for all your works and help you \nmanage your daily live",
                style: AppConstants.subtitleTextStyle,
              ),

              const SizedBox(
                height: 40,
              ),

              // a  text field with a leading icon eamil
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: " Sign up using your Email",
                      hintStyle: const TextStyle(
                        fontFamily: "Product Sans Regular",
                      ),
                      filled: true,
                      fillColor: Colors.grey[300],
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              MyWideButton(
                text: "Sign Up",
                color: AppConstants.primaryColor,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
              ),
              const Spacer(),
              //or Use instant  Sign Up text
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("  Or use  instant Sign Up option")],
              ),
              const SizedBox(
                height: 20,
              ),

              //a container button with a gray border with leading google icone saying Sign with Google
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/google.svg',
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Sign up with Google',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Product Sans Regular"),
                    ),
                  ],
                ),
              ),
              // a container button with a gray border with a leading Githb icon syaing sign in with Github
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width

                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/git.svg',
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Sign up with GitHub',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Product Sans Regular"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // already have an account text?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    " Already have an Account?",
                    style: TextStyle(fontFamily: 'Product Sans Regular'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              fontFamily: 'Product Sans Regular',
                              color: Colors.blue)))
                ],
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
