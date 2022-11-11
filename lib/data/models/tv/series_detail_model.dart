import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  final String? posterPath;
  final List<GenreModel> genres;
  final List<int> episodeRunTime;
  final String overview;
  final String originalName;
  final double voteAverage;
  final int id;

  TvSeriesDetailResponse({
    required this.posterPath,
    required this.genres,
    required this.episodeRunTime,
    required this.overview,
    required this.originalName,
    required this.voteAverage,
    required this.id,
  });

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        posterPath: json["poster_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        overview: json["overview"],
        originalName: json["original_name"],
        voteAverage: json["vote_average"].toDouble(),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "overview": overview,
        "original_name": originalName,
        "vote_average": voteAverage,
        "id": id,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x))
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
        posterPath: posterPath,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        episodeRunTime: episodeRunTime,
        overview: overview,
        originalName: originalName,
        voteAverage: voteAverage,
        id: id);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        posterPath,
        overview,
        originalName,
        voteAverage,
        id,
        genres,
        episodeRunTime
      ];
}
