import 'dart:math';

import 'package:arpeggiare/module/home/widget/posts.widget.dart';
import 'package:flutter/cupertino.dart';

import '../client/post.client.dart';

class PostProvider extends ChangeNotifier {
  List<PostResponse> posts = [];
  bool isLoading = false;
  bool hasMore = true;

  request(int page, int limit) async {
    isLoading = true;
    notifyListeners();
    final newPosts = await PostClient.getPosts(page, limit);

    if (newPosts.isEmpty) {
      hasMore = false;
    }

    posts = [...posts, ...newPosts];
    isLoading = false;
    notifyListeners();
  }
}
