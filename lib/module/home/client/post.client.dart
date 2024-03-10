import 'dart:math';

class PostClient {
  static var posts = List.generate(
      23,
      (index) => PostResponse(
            title: 'Post $index',
            content: 'Content $index',
            author: 'Author $index',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            images: [
              "https://postfiles.pstatic.net/MjAyNDAyMjlfODMg/MDAxNzA5MTY1MjcwMzQ0.o5jJvEfdlWDjydecK0d7xPN2e4fZdblBfEjCvR2afqog.w0RJjidbyFN2h05nXVO5MYfunq9iSF5ipq4GcAIPDuog.JPEG/01D40B95-4113-4225-80EE-BA08C289F8FD.jpg?type=w966",
            ],
          ));

  static Future<List<PostResponse>> getPosts(int page, int limit) async {
    await Future.delayed(Duration(seconds: 1));

    if (page * limit >= posts.length) {
      return [];
    }

    return posts.sublist(page * limit, min(page * limit + limit, posts.length));
  }
}

class PostResponse {
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> images;
  final String? video;

  PostResponse({
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    this.video,
  });
}
