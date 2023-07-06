import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_android/features/videos/view_models/timeline_vm.dart';
import 'package:tiktok_clone_android/features/videos/views/widgets/video_post.dart';

class VideoTimeLineScreen extends ConsumerStatefulWidget {
  const VideoTimeLineScreen({super.key});

  @override
  VideoTimeLineScreenState createState() => VideoTimeLineScreenState();
}

class VideoTimeLineScreenState extends ConsumerState<VideoTimeLineScreen> {
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
    //ref.watch().when을 사용하는 이유는 timelineprovider가 timelinemodel을 통해 data를 loading하는데 시간이 소요되기 때문이다.
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos : $error",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (videos) => RefreshIndicator(
            displacement: 40,
            edgeOffset: 20,
            onRefresh: _onRefresh,
            color: Theme.of(context).primaryColor,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) =>
                  VideoPost(onVideoFinished: _onVideoFinished, index: index),
            ),
          ),
        );
  }
}
