import 'package:tmda/core/utils/enums.dart';
import 'package:tmda/features/actors/domain/entities/actor_credit.dart';

class ActorCreditModel extends ActorCredit {
  const ActorCreditModel({
    required super.id,
    required super.title,
    required super.type,
    super.posterPath,
    super.character,
    super.releaseDate,
    super.rating,
  });

  factory ActorCreditModel.fromJson(Map<String, dynamic> json) {
    final isMovie = json['media_type'] == 'movie';

    return ActorCreditModel(
      id: json['id'],
      title: isMovie ? json['title'] : json['name'],
      posterPath: json['poster_path'],
      character: json['character'],
      releaseDate: isMovie ? json['release_date'] : json['first_air_date'],
      type: isMovie ? ActorCreditType.movie : ActorCreditType.tv,
      rating: json['vote_average'],
    );
  }
}
