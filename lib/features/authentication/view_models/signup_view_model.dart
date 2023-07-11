import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_android/features/authentication/repos/authentication_repo.dart';

//Expose Nothing, Because this view model just show loading screen when we create user account and do trigger that account creation
class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    //AuthenticationRepository를 초기화
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp() async {
    //작업을 시작하면 사용자에게 로딩중이라고 알림
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    //AsyncValue.guard는 error가 있으면 error를 expose하고 error가 없다면 해당 data를 저장하고 아무것도 return하지 않음
    state = await AsyncValue.guard(
      //AuthenticationRepository의 signUp을 통해 user account를 creation함
      () async => await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      ),
    );
  }
}

//StateProvider is A Provider that exposes a value that can be modified from outside
//이 form state를 사용하여 유저가 화면에 적는 정보를 form에 저장함
final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
