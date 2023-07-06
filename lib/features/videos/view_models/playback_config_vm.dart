import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_android/features/videos/models/palyback_config_model.dart';
import 'package:tiktok_clone_android/features/videos/repos/video_playback_config_repo.dart';

//provider는 데이터를 저장할 때 사용 되는 것 뿐만 아님
//메서드를 실행하기 위해서도 사용됨
class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final VideoPlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    //값이 변경 될 때 마다 state를 새로 만들어야한다. 기존의 state를 새 state로 대체하는 것임.
    //state.muted = value와 같은 것은 사용할 수 없음.
    //state가 변경된다는 것은 모든 화면들이 새로고침 한다는 것이다.
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

//playbackConfigViewModel은 메서드를 사용하기 위해서 있는 것임
//playbackConfigModel은 데이터를 저장하기 위해서 있는 것임. 데이터는 모두 모델을 통해서 전달됨.
//여기서 playbackConfigViewModel의 provider를 만들기 위해서는 repository를 매개변수로 사용해야함.
//하지만 repository를 얻기 위해서는 Sharedpreferences의 preferences가 필요함.(하지만 접근이 불가하여 initialize를 할 수 없음)
//그래서 이 예시의 한해서만 SharedPreferences에 접근하기 위해서 unimplementederror를 throw하는 것임.
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
