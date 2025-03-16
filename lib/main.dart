import 'package:flutter/material.dart';

import 'widgets/spending_saving_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          surface: Colors.white,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Paint Example')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: const SpendingSavingWidget(),
          ),
        ),
      ),
    );
  }
}
