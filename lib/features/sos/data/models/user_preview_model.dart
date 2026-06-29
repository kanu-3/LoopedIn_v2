class UserPreviewModel {
  final String userId;
  final String username;
  final String name;
  final String? profilePic;

  const UserPreviewModel({
    required this.userId,
    required this.username,
    required this.name,
    this.profilePic,
  });

  factory UserPreviewModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return UserPreviewModel(
      userId: (json['user_id'] ?? '').toString(),
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      profilePic: json['profile_pic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'name': name,
      'profile_pic': profilePic,
    };
  }

  UserPreviewModel copyWith({
    String? userId,
    String? username,
    String? name,
    String? profilePic,
  }) {
    return UserPreviewModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
    );
  }
}