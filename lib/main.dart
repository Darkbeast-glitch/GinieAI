import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ginie_ai/components/constants.dart';
import 'package:ginie_ai/firebase_options.dart';
import 'package:ginie_ai/pages/ai_chat_page.dart';
import 'package:ginie_ai/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ... other properties
      routes: {
        '/chat': (context) => const ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      title: "GinieAI",
      theme: ThemeData(
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppConstants.textColor),
          bodyMedium: TextStyle(color: AppConstants.textColor),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppConstants.primaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
