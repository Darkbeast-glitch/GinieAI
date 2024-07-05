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
                  SizedBox(width: 20),
                  Text(
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
          (Route<dynamic> route) => false,
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
            const Spacer(flex: 2),
            const Text("Hello Again", style: AppConstants.titleTextStyle),
            const SizedBox(height: 20),
            const Text(
              "Welcome back, You've been missed",
              textAlign: TextAlign.center,
              style: AppConstants.subtitleTextStyle,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextForm(
                      controller: _emailController,
                      hintText: "Enter your email",
                      obsecureText: false,
                      prefix: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 30),
                    MyTextForm(
                      controller: _passwordController,
                      obsecureText: true,
                      hintText: "Enter your password",
                      prefix: const Icon(Icons.lock),
                      errorText: "Please enter your password",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ForgotPassword(),
                  ),
                );
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  fontFamily: "Product Sans Regular",
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 30),
            MyWideButton(
              text: "Login",
              color: AppConstants.primaryColor,
              onTap: _loginUser,
            ),
            const Spacer(),
            const Text("Or use instant Sign Up option"),
            const SizedBox(height: 20),
            _buildSignInButton(
                'assets/images/google.svg', 'Sign In with Google'),
            const SizedBox(height: 20),
            _buildSignInButton('assets/images/git.svg', 'Sign in with GitHub'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an Account?",
                    style: TextStyle(fontFamily: 'Product Sans Regular')),
                const SizedBox(width: 5),
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
                          color: Colors.blue)),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton(String assetPath, String buttonText) {
    return Container(
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
          SvgPicture.asset(assetPath, height: 30),
          const SizedBox(width: 10),
          Text(
            buttonText,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: "Product Sans Regular"),
          ),
        ],
      ),
    );
  }
}
