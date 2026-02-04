import 'package:tmda/features/actors/domain/entities/actor_details.dart';

class ActorDetailsModel extends ActorDetails {
  const ActorDetailsModel({
    required super.id,
    required super.name,
    super.biography,
    super.profilePath,
    super.birthday,
    super.placeOfBirth,
  });

  factory ActorDetailsModel.fromJson(Map<String, dynamic> json) {
    return ActorDetailsModel(
      id: json['id'],
      name: json['name'],
      biography: json['biography'],
      profilePath: json['profile_path'],
      birthday: json['birthday'],
      placeOfBirth: json['place_of_birth'],
    );
  }
}
