import 'package:flutter/material.dart';
import 'package:tiktok_clone_android/features/utils.dart';
import 'package:tiktok_clone_android/features/videos/widgets/video_post.dart';

class VideoTimeLineScreen extends StatefulWidget {
  const VideoTimeLineScreen({super.key});

  @override
  State<VideoTimeLineScreen> createState() => _VideoTimeLineScreenState();
}

class _VideoTimeLineScreenState extends State<VideoTimeLineScreen> {
  final PageController _pageController = PageController();

  int _itemCountInt = 4;
  final Duration _scollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCountInt - 1) {
      _itemCountInt = _itemCountInt + 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: _scollDuration,
      curve: _scrollCurve,
    );
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkMode(context);
    return RefreshIndicator(
      displacement: 40,
      edgeOffset: 20,
      onRefresh: _onRefresh,
      color: Theme.of(context).primaryColor,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _itemCountInt,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) =>
            VideoPost(onVideoFinished: _onVideoFinished, index: index),
      ),
    );
  }
}
