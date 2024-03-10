import 'package:arpeggiare/module/home/provider/post.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'module/home/home.page.dart';

class ArpeggiareApp extends StatelessWidget {
  const ArpeggiareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arpeggiare',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => PostProvider()),
    ], child: ArpeggiareApp()),
  );
}
