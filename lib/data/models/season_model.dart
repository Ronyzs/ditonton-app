import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        episodeCount: json["episode_count"] ?? 'Unknown',
        id: json["id"],
        name: json["name"],
        overview: json["overview"] ?? '',
        posterPath: json["poster_path"] ?? "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  Season toEntity() {
    return Season(
      episodeCount: this.episodeCount,
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
