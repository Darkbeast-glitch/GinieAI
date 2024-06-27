import 'package:flutter/material.dart';
import 'package:ginie_ai/components/ai_boxes.dart';
import 'package:ginie_ai/components/constants.dart';
// import 'package:ginie_ai/components/filterchipwidget.dart';

class AllAssistants extends StatelessWidget {
  const AllAssistants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: const <Widget>[
                FeatureCard(
                  icon: Icons.surround_sound,
                  title: "Voice-Activated Assitance",
                  description:
                      "Use voice commands in English and local dialects to interact with GinieAI.",
                ),
                FeatureCard(
                  icon: Icons.car_repair,
                  title: "Effortless Ride \nBooking",
                  description:
                      "Book Uber rides with simple voice commands for hassle-free transportation.",
                ),
                FeatureCard(
                  icon: Icons.run_circle_outlined,
                  title: "Instant Emergency \nAssistance",
                  description:
                      "Quickly connect with emergency services and share your location for prompt support.",
                ),
                FeatureCard(
                  icon: Icons.work_history_rounded,
                  title: "Job Opportunity \nAlerts",
                  description:
                      "GinieAI alerts you to job openings matching your skills.",
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
