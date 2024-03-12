import 'package:arpeggiare/module/home/provider/post.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';

import 'module/home/home.page.dart';
import 'module/map/map.page.dart';

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
      home: PositionPermissionPage(),
    );
  }
}

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
    clientId: dotenv.get("NCLOUD_MAP_CLIENT_ID"),
    onAuthFailed: (ex) {
      debugPrint("********* 네이버맵 인증오류 : $ex *********");
    },
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => PostProvider()),
    ], child: ArpeggiareApp()),
  );
}
