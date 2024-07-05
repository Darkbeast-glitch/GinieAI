import 'package:flutter/material.dart';
import 'package:ginie_ai/components/button.dart';
import 'package:ginie_ai/components/constants.dart';
import 'package:ginie_ai/services/auth_services.dart';
import 'package:ginie_ai/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return Scaffold(
      body: Center(
        child: MyButton(
          text: "Logout",
          color: AppConstants.primaryColor,
          onTap: () async {
            await authService.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Logged out successfully'),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }
}
