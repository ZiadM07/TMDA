import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.username,
    required super.name,
    required super.avatarPath,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      avatarPath: json['avatar']?['tmdb']?['avatar_path'],
    );
  }
}
