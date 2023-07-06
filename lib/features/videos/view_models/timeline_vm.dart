import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_android/features/videos/models/video_model.dart';

//VideoModel의 Data를 List형태로 불러와줄 것이다라는 뜻이다.
class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  void uploadVideo() async {
    //TimelineViewModel의 state가 다시 loading하게 하는 것임
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    final newVideo = VideoModel(title: "${DateTime.now()}");
    _list = [..._list, newVideo];
    //-------------------------여기까지 되면 새로운 data가 firebase에 저장이 될 것이다.
    //이 class는 asyncnotifier이기 때문에 기존 state를 update해주는 것과는 다르게 이렇게 진행해야 한다.
    state = AsyncValue.data(_list);
    //-------------------------새로운 data를 갖게됨
  }

  //await를 통해 api로부터 데이터를 받아올 것이기 때문에 FutureOr에 async인 것이다.
  //build method로부터 우리가 원하는 API를 호출하고 Data를 받아온다.
  @override
  FutureOr<List<VideoModel>> build() async {
    //API로부터 Data를 받는데 까지의 응답받는 시간이 5초 정도 걸린다고 가정하는 것
    await Future.delayed(const Duration(seconds: 5));
    //여기서 Data를 반환하면 provider에 의해 expose 될 것이다.
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
