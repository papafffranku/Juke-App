import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? username;
  final String? avatarUrl;
  final String? bio;
  final String? email;
  final int? followers;
  final int? following;
  final int? songs;
  final String? socialfb;
  final String? socialig;
  final String? tag;

  UserModel({
    this.id,
    this.username,
    this.avatarUrl,
    this.bio,
    this.email,
    this.followers,
    this.following,
    this.songs,
    this.socialfb,
    this.socialig,
    this.tag,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      username: doc['username'],
      avatarUrl: doc['avatarUrl'],
      bio: doc['bio'],
      email: doc['email'],
      followers: doc['followers'],
      following: doc['following'],
      songs: doc['songs'],
      socialfb: doc['socialfb'],
      socialig: doc['socialig'],
      tag: doc['tag'],
    );
  }
}
