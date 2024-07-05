import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ginie_ai/pages/AIoptions/all_ai_screen.dart';
import 'package:ginie_ai/pages/chat_history_page.dart';
import 'package:ginie_ai/pages/profile_page.dart';
import 'package:ginie_ai/pages/welcome_page.dart';
import 'package:ginie_ai/services/firestore_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkChatHistory();
  }

  Future<void> _checkChatHistory() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      bool hasHistory =
          await _firestoreService.hasChatHistory(firebaseUser.uid);
      if (hasHistory) {
        setState(() {
          _currentIndex = 2; // Set to ChatHistoryPage index
        });
        _pageController.jumpToPage(2);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "Product Sans Regular"),
          title: const Text("GinieAI 🧞",
              style: TextStyle(fontFamily: "Product Sans Bold", fontSize: 25)),
          centerTitle: true,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: const <Widget>[
            WelcomePage(),
            AllAssistants(),
            ChatHistoryPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Material(
          elevation: 5.0,
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
              textTheme: Theme.of(context).textTheme.copyWith(
                    bodySmall: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Product Sans Regular',
                    ),
                  ),
            ),
            child: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.6),
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  _pageController.jumpToPage(index);
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assistant),
                  label: 'AI Assistants',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ));
  }
}
