import '../../domain/entities/person.dart';

class PersonModel {
  final int id;
  final String name;
  final String? profilePath;
  final double popularity;
  final String? knownForDepartment;

  PersonModel({
    required this.id,
    required this.name,
    this.profilePath,
    required this.popularity,
    this.knownForDepartment,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      popularity: (json['popularity'] as num).toDouble(),
      knownForDepartment: json['known_for_department'],
    );
  }

  Person toEntity() => Person(
        id: id,
        name: name,
        profilePath: profilePath,
        popularity: popularity,
        knownForDepartment: knownForDepartment,
      );
}
