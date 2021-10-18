class UserModel {
  late final String avatarUrl;
  late final String username;
  UserModel({required this.avatarUrl, required this.username});

  UserModel.fromMap(Map<String, dynamic> data) {
    avatarUrl = data['avatarUrl'];
    username = data['username'];
  }
}
