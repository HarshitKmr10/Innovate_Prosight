import 'dart:convert';

import 'package:abstract_curiousity/globalvariables.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<String> chatGPTAPI(String prompt) async {
    final List<Map<String, String>> messages = [];
    messages.add({
      'role': 'user',
      'content':
          "Please summarise in points and return output as dart list $prompt",
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        printError(content);
        print(res.statusCode.toString());
        // messages.add({
        //   'role': 'assistant',
        //   'content': content,
        // });
        return content;
      }
      return "Failed to summarise text";
    } catch (e) {
      return e.toString();
    }
  }
}
