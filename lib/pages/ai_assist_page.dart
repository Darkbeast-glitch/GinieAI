import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ginie_ai/providers/generative_model_provider.dart';
import 'package:ginie_ai/services/firestore_service.dart';
import 'dart:convert';
import 'dart:math';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class AiAssistPage extends ConsumerStatefulWidget {
  const AiAssistPage({super.key});

  @override
  ConsumerState<AiAssistPage> createState() => _AiAssistPageState();
}

class _AiAssistPageState extends ConsumerState<AiAssistPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  late types.User _user;
  final _aiUser = const types.User(id: 'ginie-ai');

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      _user = types.User(id: firebaseUser.uid);
      setState(() {});
    } else {
      // Handle user not authenticated
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GinieAI🧞',
          style: TextStyle(fontFamily: "Product Sans Bold"),
        ),
        centerTitle: true,
      ),
      body: _user != null
          ? StreamBuilder<List<types.Message>>(
              stream: _firestoreService.getMessageStream(_user.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading messages'));
                } else {
                  final messages = snapshot.data ?? [];
                  return Chat(
                    messages: messages,
                    onSendPressed: _handleSendPressed,
                    user: _user,
                    customMessageBuilder: _buildCustomMessage,
                  );
                }
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCustomMessage(types.Message message,
      {required int messageWidth}) {
    if (message is types.TextMessage) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.author.id == _user.id
              ? Colors.blue[100]
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: MarkdownBody(data: message.text),
      );
    }
    return Container();
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _generateRandomString(),
      text: message.text,
    );

    await _firestoreService.saveMessage(textMessage, _user.id);

    // Show Gemini is typing indicator
    final typingMessage = types.TextMessage(
      author: _aiUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _generateRandomString(),
      text: '...',
    );
    await _firestoreService.saveMessage(typingMessage, _user.id);

    try {
      // Use the provider to get the GenerativeModel instance
      final generativeModel = ref.read(generativeModelProvider);

      // Send the user's message to the Gemini API and get a response
      final responseText =
          await getResponseFromGemini(generativeModel, message.text);

      // Remove typing indicator
      await _firestoreService.deleteMessage(typingMessage, _user.id);

      if (responseText != null) {
        final aiResponseMessage = types.TextMessage(
          author: _aiUser,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: _generateRandomString(),
          text: responseText,
        );
        await _firestoreService.saveMessage(aiResponseMessage, _user.id);
      }
    } catch (e) {
      // Remove typing indicator
      await _firestoreService.deleteMessage(typingMessage, _user.id);

      // Handle error (e.g., show a message or log it)
      final errorMessage = types.TextMessage(
        author: _aiUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: _generateRandomString(),
        text: 'Error: Unable to get response from Gemini.',
      );
      await _firestoreService.saveMessage(errorMessage, _user.id);
      print('Error generating content: $e');
    }
  }

  String _generateRandomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
