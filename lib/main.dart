import 'package:flutter/material.dart';
import 'loadingPage.dart'; // 로딩 페이지를 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      // 처음에는 로딩 페이지를 보여줌
      home: LoadingPage(),
    );
  }
}
