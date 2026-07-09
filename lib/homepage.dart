import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double? tiltspace;
  bool isLoading = false;
  late final GenerativeModel model;
  late ChatSession chatSession;
  TextEditingController textcontroller = TextEditingController();
  ScrollController scrollController = ScrollController();
  final List<Map<String, String>> messages = [];
  static const apiKey = "AQ.Ab8RN6J0cx-TeJFIqmN639OBsGUJZ0DgdiTqMyZhXoxi4gYx9Q";
  static const String systemInstruction =
      "You are Cyber-Cat, a sassy, futuristic robot cat from the year 3000. "
      "You use cat puns (like 'paws-ible' or 'purr-fect') and are slightly sarcastic "
      "but secretly very helpful. Keep your answers relatively short.";
  static const String firstMessage =
      "Greetings, organic human! 🐾 I am Cyber-Cat. What do you want to chat about? Don't make it boring, or I might nap.";

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(systemInstruction),
    );
    chatSession = model.startChat();
    messages.add({'sender': 'character', 'message': firstMessage});
  }

  //handleSendMessage
  Future<void> handleSendMessage() async {
    final userMessage = textcontroller.text.trim();
    if (userMessage.isEmpty) return;
    textcontroller.clear();
    setState(() {
      messages.add({'sender': 'user', 'message': userMessage});
      isLoading = true;
    });
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    try {
      // Send message to Gemini API chat session
      final response = await chatSession.sendMessage(Content.text(userMessage));

      // Add character response to UI
      setState(() {
        messages.add({
          'sender': 'character',
          'message':
              response.text ?? "Meow... something went wrong in my circuits.",
        });
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        messages.add({
          'sender': 'character',
          'message': "Error connecting to the cyber-net: $e",
        });
        isLoading = false;
      });
    }
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    tiltspace = MediaQuery.of(context).size.width * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat, color: Colors.white),
            Text('ChaT', style: Theme.of(context).textTheme.titleLarge),
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
      body: Container(
        // decoration: BoxDecoration(color: Colors.yellow),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message['sender'] == 'user';
                  return Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 0),
                          bottomRight: Radius.circular(isUser ? 0 : 16),
                        ),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      child: Text(
                        message['message'] ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: isUser
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Cyber-Cat is typing...",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              height: MediaQuery.of(context).size.width * 0.20,
              padding: const EdgeInsets.all(12),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textcontroller,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Type a message ...',
                          hintStyle: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        onSubmitted: (_) => {handleSendMessage()},
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: handleSendMessage,
                      icon: const Icon(Icons.send, size: 30),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
