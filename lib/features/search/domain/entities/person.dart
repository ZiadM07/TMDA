class Person {
  final int id;
  final String name;
  final String? profilePath;
  final double popularity;
  final String? knownForDepartment;

  const Person({
    required this.id,
    required this.name,
    this.profilePath,
    required this.popularity,
    this.knownForDepartment,
  });
}
