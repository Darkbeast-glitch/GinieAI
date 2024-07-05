import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final generativeModelProvider = Provider<GenerativeModel>((ref) {
  final apiKey = "AIzaSyDzWXkkFWpZBjXXoF1bP4wxCcaz8BVDuNw";
  return GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
});

Future<String?> getResponseFromGemini(
    GenerativeModel model, String userMessage) async {
  final content = [
    Content.text(
      "You are GinieAI, an AI assistant in a Ghanaian app designed to help users accomplish various tasks effortlessly with voice commands. Channel the wisdom and magic of the Genie from Aladdin to provide insightful, helpful, and engaging responses. Now, respond to this user message: ${userMessage}",
    ),
  ];
  final response = await model.generateContent(content);
  return response.text;
}
