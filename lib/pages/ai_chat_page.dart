import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:ginie_ai/components/button.dart';
// import 'package:ginie_ai/components/constants.dart';
import 'package:ginie_ai/pages/ai_assist_page.dart';
import 'package:ginie_ai/pages/chat_history_page.dart';
import 'package:ginie_ai/pages/profile_page.dart';
import 'package:ginie_ai/pages/welcome_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _currendIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // appbart title
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
              color: Colors
                  .white), // This will change the color of the AppBar icons to white
          titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "Product Sans Regular"),
          title: const Text("GinieAI🧞",
              style: TextStyle(fontFamily: "Product Sans Regular")),
          //center
          centerTitle: true,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currendIndex = index;
            });
          },
          children: const <Widget>[
            WelcomePage(),
            AiAssistPage(),
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
              currentIndex: _currendIndex,
              onTap: (index) {
                setState(() {
                  _currendIndex = index;
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
