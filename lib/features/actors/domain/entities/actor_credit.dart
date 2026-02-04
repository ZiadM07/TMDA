import 'package:tmda/core/utils/enums.dart';

class ActorCredit {
  final int id;
  final String title;
  final String? posterPath;
  final String? character;
  final ActorCreditType type;
  final String? releaseDate;
  final double? rating;

  const ActorCredit({
    required this.id,
    required this.title,
    required this.type,
    this.posterPath,
    this.character,
    this.releaseDate,
    this.rating,
  });
}
