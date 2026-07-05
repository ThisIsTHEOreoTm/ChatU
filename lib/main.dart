import 'package:chatu/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatu',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'ArchivoBlack',
            fontSize: 20,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontFamily: 'ArchivoBlack',
            fontSize: 16,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'ArchivoBlack',
            fontSize: 24,
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            fontFamily: 'ChangaOne',
            fontSize: 16,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontFamily: 'ChangaOne',
            fontSize: 20,
            color: Colors.white,
          ),
          displayLarge: TextStyle(
            fontFamily: 'ChangaOne',
            fontSize: 24,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontFamily: 'ChangaOne',
            fontSize: 34,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontFamily: 'ChangaOne',
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
