import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'dart:convert';
import 'dart:math';
import 'package:google_generative_ai/google_generative_ai.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class AiAssistPage extends StatefulWidget {
  const AiAssistPage({super.key});

  @override
  State<AiAssistPage> createState() => _AiAssistPageState();
}

class _AiAssistPageState extends State<AiAssistPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _aiUser = const types.User(id: 'gemini-ai');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GinieAI🧞',
          style: TextStyle(fontFamily: "Product Sans Regular"),
        ),
        centerTitle: true,
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    _addMessage(textMessage);

    // Show Gemini is typing indicator
    final typingMessage = types.TextMessage(
      author: _aiUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: '...',
    );
    _addMessage(typingMessage);

    try {
      // Send the user's message to the Gemini API and get a response
      final responseText = await _getResponseFromGemini(message.text);

      // Remove typing indicator
      setState(() {
        _messages.removeWhere((msg) => msg.id == typingMessage.id);
      });

      if (responseText != null) {
        final aiResponseMessage = types.TextMessage(
          author: _aiUser,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: randomString(),
          text: responseText,
        );
        _addMessage(aiResponseMessage);
      }
    } catch (e) {
      // Remove typing indicator
      setState(() {
        _messages.removeWhere((msg) => msg.id == typingMessage.id);
      });

      // Handle error (e.g., show a message or log it)
      final errorMessage = types.TextMessage(
        author: _aiUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: 'Error: Unable to get response from Gemini.',
      );
      _addMessage(errorMessage);
      print('Error generating content: $e');
    }
  }

  Future<String?> _getResponseFromGemini(String userMessage) async {
    // Use your API key directly (ensure this is secure in production)
    final apiKey = "AIzaSyDzWXkkFWpZBjXXoF1bP4wxCcaz8BVDuNw";
    if (apiKey == null) {
      print('No \$API_KEY environment variable');
      return null;
    }

    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [
      Content.text(
          "You are GinieAI, an AI assistant in a Ghanaian app designed to help users accomplish various tasks effortlessly with voice commands. Channel the wisdom and magic of the Genie from Aladdin to provide insightful, helpful, and engaging responses. Now, respond to this user message: ${userMessage}")
    ];
    final response = await model.generateContent(content);

    return response.text;
  }
}
