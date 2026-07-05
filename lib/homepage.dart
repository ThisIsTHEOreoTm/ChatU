import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final String apiKey = "AQ.Ab8RN6J0cx-TeJFIqmN639OBsGUJZ0DgdiTqMyZhXoxi4gYx9Q";
  double? tiltspace;
  @override
  Widget build(BuildContext context) {
    tiltspace = MediaQuery.of(context).size.width * 0.02;

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(
        "You are Cyber-Cat, a sassy, futuristic robot cat from the year 3000. "
        "You use cat puns (like 'paws-ible' or 'purr-fect') and are slightly sarcastic "
        "but secretly very helpful. Keep your answers relatively short.",
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat, color: Colors.white),
            Text('Chat', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(width: tiltspace),
            Text(
              'U',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.deepPurpleAccent),
            ),
          ],
        ),
      ),
      body: ListView(children: [


        ],
      ),
    );
  }
}
