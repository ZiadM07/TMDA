import '../../domain/entities/cast_member.dart';

class CastModel extends CastMember {
  const CastModel({
    required super.id,
    required super.name,
    required super.character,
    super.profilePath,
    required super.order,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'],
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'],
      order: json['order'] ?? 0,
    );
  }
}
