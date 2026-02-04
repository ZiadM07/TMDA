import 'package:tmda/features/tv/domain/entities/tv_video.dart';

class TvVideoModel extends TvVideo {
  const TvVideoModel({
    required super.id,
    required super.key,
    required super.name,
    required super.site,
    required super.type,
  });

  factory TvVideoModel.fromJson(Map<String, dynamic> json) {
    return TvVideoModel(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      site: json['site'],
      type: json['type'],
    );
  }
}
