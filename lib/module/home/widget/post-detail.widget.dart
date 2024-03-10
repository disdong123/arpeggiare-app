import 'dart:async';

import 'package:arpeggiare/module/home/client/post.client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class PostDetailWidget extends StatelessWidget {
  final PostResponse post;

  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(post.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('작성자: ${post.author}',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 5),
              Text('작성일: ${DateFormat('yyyy-MM-dd').format(post.createdAt)}',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 5),
              Text('수정일: ${DateFormat('yyyy-MM-dd').format(post.updatedAt)}',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 20),
              Text(post.content, style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              if (post.images.isNotEmpty) _buildImageSlider(post.images),
              if (post.video != null)
                InkWell(
                  onTap: () {
                    // 비디오를 재생할 수 있는 액션 추가
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.play_circle_fill,
                            size: 50, color: Colors.red),
                        SizedBox(width: 10),
                        Text('비디오 보기',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider(List<String> images) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.network(images[index]),
          );
        },
      ),
    );
  }
}

class VideoViewerWidget extends StatefulWidget {
  const VideoViewerWidget({super.key, required this.post});

  final PostResponse post;

  @override
  State<VideoViewerWidget> createState() => _VideoViewerWidgetState();
}

class _VideoViewerWidgetState extends State<VideoViewerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  // 아이콘의 표시 상태를 위한 변수를 0.0 (완전 투명)으로 초기화합니다.
  double _iconOpacity = 0.0;
  Timer? _iconVisibilityTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    _controller.addListener(() {
      final isCurrentlyPlaying = _controller.value.isPlaying;
      if (isCurrentlyPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isCurrentlyPlaying;
        });
      }
    });
  }

  void _toggleIcon() {
    setState(() {
      _iconOpacity = 1.0; // 아이콘을 보이게 합니다.
    });
    _iconVisibilityTimer?.cancel();
    _iconVisibilityTimer = Timer(Duration(milliseconds: 500), () {
      // 500ms 후에 아이콘을 점차 사라지게 합니다.
      setState(() {
        _iconOpacity = 0.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _iconVisibilityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          Container(
            // color: Colors.black,
            child: Text(widget.post.title),
          ),
          Center(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GestureDetector(
                    onTap: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                      _toggleIcon();
                    },
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          // AnimatedOpacity를 사용하여 아이콘의 표시 및 사라짐을 처리합니다.
          Center(
            child: AnimatedOpacity(
              opacity: _iconOpacity, // 아이콘의 투명도를 동적으로 관리합니다.
              duration: Duration(milliseconds: 500), // 투명도 변화에 걸리는 시간을 설정합니다.
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 60, // 아이콘 크기를 조정합니다.
                color: Colors.white.withOpacity(0.8), // 아이콘 색상과 투명도를 설정합니다.
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 50,
            child: FloatingActionButton(
              child: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailWidget(post: widget.post),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
