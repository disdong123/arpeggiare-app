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
            "https://postfiles.pstatic.net/MjAyNDAyMDFfMTcx/MDAxNzA2NzY1OTQzMDQ4.9Emms9njwoeR0kwfDPHVYaq-UeCkyJovNjwG4rzHES4g.eSAVFBvwtMoNxlEz2-LT_T7DPJZrFAlIxHl5XYdedlwg.JPEG.love_e/101745FC-B2FF-487B-A284-74E44A7B164E.jpg?type=w966",
            "https://postfiles.pstatic.net/MjAyNDAyMjlfNzIg/MDAxNzA5MTY1MjU2MDAz.wHtDvTvZAe-PONE6QDKENKi7dONanLH44VCpIMRw-J0g.-EZ7qbXaNEswTVYtrg1uVAEHsKd0Inn5paWR4ur1o6Eg.JPEG/IMG_7165.JPG?type=w466",
            "https://postfiles.pstatic.net/MjAyNDAyMjlfMTQ2/MDAxNzA5MTY1MjU3MjY5.N2spGo4Ny0WI4ZZGMCdYkXYuNahEbtiL9zNjV68kUkEg.xmQY55i9QP-sxINVbtGmBawjwkitHoWwPFh0ZB3tIL8g.JPEG/IMG_7166.JPG?type=w466"
          ],
          video:
              "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4"));

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
