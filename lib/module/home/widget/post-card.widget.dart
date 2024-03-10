import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../client/post.client.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({super.key, required this.post});
  final PostResponse post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // 컨테이너 모서리를 둥글게 합니다.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 리스트가 있을 경우 첫 번째 이미지를 표시합니다.
            if (post.images.isNotEmpty)
              Image.network(
                post.images.first,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${post.author}, ${_formatDate(post.createdAt)}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    post.content,
                    style: TextStyle(fontSize: 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (post.video != null)
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                alignment: Alignment.centerLeft,
                child:
                    Icon(Icons.play_circle_fill, size: 40, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    // 날짜를 'yyyy년 MM월 dd일' 형식으로 포매팅합니다.
    return DateFormat('yyyy년 MM월 dd일').format(dateTime);
  }
}
