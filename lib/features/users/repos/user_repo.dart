import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_android/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    //signUp에서 user로부터 받은 userProfile 정보를 firestore에 저장하는 방법이다.
    //users collection에 사용자의 id에 Json형태로 저장하는 것이다.
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }
}

final userRepo = Provider((ref) => UserRepository());
