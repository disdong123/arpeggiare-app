import 'package:arpeggiare/module/home/widget/posts.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Future<List<PostResponse>> posts = PostRepository.getPosts(0);

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
        body: FutureBuilder(
          future: posts,
          builder: (BuildContext context,
              AsyncSnapshot<List<PostResponse>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(height: 30),
                  Expanded(
                    child: PostsWidget(posts: snapshot.data!),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
