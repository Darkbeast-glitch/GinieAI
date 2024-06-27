import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final generativeModelProvider = FutureProvider<GenerativeModel>((ref) async {
  final apiKey = Platform.environment['API_KEY'];
  if (apiKey == null) {
    print('No \$API_KEY environment variable found.');
    exit(1);
  }
  return GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
});
