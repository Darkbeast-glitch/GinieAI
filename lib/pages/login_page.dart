import 'package:flutter/material.dart';
import 'package:ginie_ai/components/button.dart';
import 'package:ginie_ai/components/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ginie_ai/components/my_textform.dart';
import 'package:ginie_ai/pages/ai_chat_page.dart';
import 'package:ginie_ai/pages/forgot_password._page.dart';
import 'package:ginie_ai/pages/register_page.dart';
import 'package:ginie_ai/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> _loginUser() async {
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
                  Text(
                    textAlign: TextAlign.center,
                    "Processing...",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Product Sans Regular'),
                  ),
                ],
              ),
            ),
          );
        },
      );

      String? result = await _authService.login(
          email: _emailController.text, password: _passwordController.text);

      Navigator.of(context).pop(); // Close the dialog

      if (result == 'Success') {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ChatPage()),
          (Route<dynamic> route) =>
              false, // Remove all routes below the ChatPage
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: $result'),
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

              const Text("Hello Again", style: AppConstants.titleTextStyle),

              //sub text talking about how they can login
              const SizedBox(
                height: 20,
              ),

              const Text(
                textAlign: TextAlign.center,
                "Welcome back, You've been \nmissed",
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
                        hintText: " Enter with your email ",
                        obsecureText: false,
                        prefix: const Icon(
                          Icons.email,
                        ),
                        // errorText: "Please enter your email",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // password field
                      MyTextForm(
                        controller: _passwordController,
                        obsecureText: true,
                        hintText: " Enter your Password",
                        prefix: const Icon(Icons.password_rounded),
                        errorText: "Please enter your password",
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
                    Text("Forgot Password?",
                        style: TextStyle(
                          fontFamily: "Product Sans Regular",
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyWideButton(
                text: "Login",
                color: AppConstants.primaryColor,
                onTap: _loginUser,
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
                    " Don't have an Account?",
                    style: TextStyle(fontFamily: 'Product Sans Regular'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text("Create account",
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
