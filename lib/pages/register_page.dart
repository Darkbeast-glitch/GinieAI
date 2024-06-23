import 'package:flutter/material.dart';
import 'package:ginie_ai/components/button.dart';
import 'package:ginie_ai/components/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ginie_ai/components/my_textform.dart';
import 'package:ginie_ai/pages/forgot_password._page.dart';
import 'package:ginie_ai/pages/login_page.dart';
import 'package:ginie_ai/services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final AuthService _authService = AuthService();
  // after definindg the authe instance what do i do next

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  Text("Processing..."),
                ],
              ),
            ),
          );
        },
      );

      String? result = await _authService.registration(
          email: _emailController.text, password: _passwordController.text);

      Navigator.of(context).pop(); // Close the dialog

      if (result == 'Success') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: $result'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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

              const Text("Create an Account",
                  style: AppConstants.titleTextStyle),

              //sub text talking about how they can login
              const SizedBox(
                height: 20,
              ),

              const Text(
                "Let's get you on board \nBecome a Ginie",
                textAlign: TextAlign.center,
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
                  child: Column(
                    children: [
                      MyTextForm(
                        controller: _emailController,
                        hintText: " Enter your email  ",
                        obsecureText: false,
                        prefix: const Icon(
                          Icons.email,
                        ),
                        errorText: "Plese enter an email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // password field
                      MyTextForm(
                        controller: _passwordController,
                        hintText: " Enter your Password",
                        prefix: const Icon(Icons.password_rounded),
                        obsecureText: true,
                        errorText: "Please enter your password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      MyTextForm(
                        controller: _confirmPassword,
                        hintText: " Confirm your Password",
                        prefix: const Icon(Icons.password_rounded),
                        obsecureText: true,
                        errorText: "Please enter your password",
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ForgotPassword(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Make sure your password confirmations match",
                      style: TextStyle(
                        fontFamily: "Product Sans Regular",
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyWideButton(
                  text: "Sign Up",
                  color: AppConstants.primaryColor,
                  onTap: _registerUser),
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
                      'Sign In with Google',
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
                      'Sign in with GitHub',
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
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text("Login ",
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
