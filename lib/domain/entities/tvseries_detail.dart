import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String backdropPath;
  List<dynamic> episodeRunTime;
  List<Genre> genres;
  String homepage;
  int id;
  String name;
  int numberOfEpisodes;
  int numberOfSeasons;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<Season> seasons;
  String status;
  String type;
  double voteAverage;
  int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        genres,
        homepage,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        type,
        voteAverage,
        voteCount,
      ];
}
