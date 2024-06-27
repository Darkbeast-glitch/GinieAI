import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ginie_ai/components/button.dart';
import 'package:ginie_ai/components/constants.dart';
import 'package:ginie_ai/services/auth_services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // create an instance of AuthServices
    final AuthService authService = AuthService();
    return Scaffold(
        body: Center(
      child: MyButton(
          text: "Logout",
          color: AppConstants.primaryColor,
          onTap: () async {
            await authService.logout();
          }),
    ));
  }
}
