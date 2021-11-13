import 'package:firebase_auth/firebase_auth.dart';

class UserBanner {
  final String avatarUrl;
  final String id;
  final String username;

  UserBanner(
      {required this.avatarUrl, required this.id, required this.username});

  factory UserBanner.fromDocument(doc) {
    return UserBanner(
        avatarUrl: doc['avatarUrl'], id: doc['id'], username: doc['username']);
  }
}
