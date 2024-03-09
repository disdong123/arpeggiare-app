import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostRepository {
  static var posts = List.generate(100, (index) => PostResponse("hello"));

  static Future<List<PostResponse>> getPosts(page) async {
    await Future.delayed(Duration(seconds: 1));
    return posts;
    // return posts.sublist(page, 10);
  }
}

class PostsWidget extends StatelessWidget {
  const PostsWidget({super.key, required this.posts});
  final List<PostResponse> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return PostWidget(post: posts[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 50);
      },
    );
  }
}

class PostResponse {
  final String title;

  PostResponse(this.title);
}

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});
  final PostResponse post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Text(
              post.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )),
        SizedBox(height: 30),
        Container(
          child: Text(
            post.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
