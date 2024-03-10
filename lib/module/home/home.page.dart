import 'package:arpeggiare/module/home/provider/post.provider.dart';
import 'package:arpeggiare/module/home/widget/posts.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 30,
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          title: Text(
            'ARPEGGIARE',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        body: PostsWidget());
  }
}
