import 'dart:ffi';

import 'package:arpeggiare/module/home/provider/post.provider.dart';
import 'package:arpeggiare/module/home/widget/post-card.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../client/post.client.dart';

class PostsWidget extends StatefulWidget {
  const PostsWidget({super.key});

  @override
  State<PostsWidget> createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget> {
  var page = 0;
  var limit = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      Provider.of<PostProvider>(context, listen: false).request(page, limit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context);
    final posts = provider.posts;
    final loading = provider.isLoading;

    if (loading && posts.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (!loading && posts.isEmpty) {
      return Center(child: Text('No posts'));
    }

    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: posts.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < posts.length) {
          return PostCardWidget(post: posts[index]);
        }

        if (!provider.isLoading) {
          Future.microtask(() {
            page++;
            provider.request(page, limit);
          });
        }

        if (provider.hasMore) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text('No more posts'));
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 50);
      },
    );
  }
}
