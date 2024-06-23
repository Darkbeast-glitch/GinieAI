import 'package:flutter/material.dart';
import 'package:ginie_ai/components/button.dart';
import 'package:ginie_ai/components/constants.dart';
import 'package:ginie_ai/components/my_textform.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //container with a back button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Forget yoru password Text?
              const Text(
                "Forgot Password?",
                style: AppConstants.titleTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              // sub text telling what user to do .
              const Text(
                textAlign: TextAlign.center,
                "Type your email, we will send you \n verification code to your email",
                style: AppConstants.subtitleTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              // Form asking for users email
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child:  MyTextForm(
                    controller: _emailController,
                    obsecureText: false,
      
                    hintText: "Enter your email ",
                    prefix: const Icon(Icons.email),
                    errorText: "Please enter the right email "),
              ),
              const SizedBox(
                height: 30,
              ),
              // Reset password button
              const MyWideButton(
                text: "Reset Password",
                color: AppConstants.primaryColor,
              ),
              const Spacer(),

              // Other widgets in the column...
            ],
          ),
        ),
      ),
    );
  }
}
