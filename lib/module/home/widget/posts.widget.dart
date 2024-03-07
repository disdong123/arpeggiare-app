import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsWidget extends StatelessWidget {
  const PostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostWidget(post: PostResponse('Post 1')),
        PostWidget(post: PostResponse('Post 2')),
      ],
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
    return GestureDetector(
      child: Column(
        children: [
          Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
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
          SizedBox(height: 10),
          Text(
            post.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
