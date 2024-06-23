import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ginie_ai/components/button.dart';
import 'package:ginie_ai/components/constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // center the ginie image
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Ginpic.png",
            )
          ],
        ),
        // heading centered with  welcome to Ginie Assist
        const Gap(20),

        const Text("Welcome to Ginie Assist",
            style: TextStyle(fontFamily: "Product Sans Regular", fontSize: 28)),
        const Gap(20),

        // subtext saying start chating with
        const Text("start chatting with our the finest African Ginie",
            style: TextStyle(fontFamily: "Product Sans Regular", fontSize: 14)),
        const Gap(20),

        // whide button with startchat
        const MyWideButton(text: "Start Chat", color: AppConstants.primaryColor)

        // navigation bar with chat, Ai Assistants, history and profile
      ],
    ));
  }
}
