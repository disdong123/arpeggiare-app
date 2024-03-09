import 'package:flutter/material.dart';

import 'module/home/home.page.dart';

class ArpeggiareApp extends StatelessWidget {
  const ArpeggiareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arpeggiare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

void main() {
  runApp(const ArpeggiareApp());
}
