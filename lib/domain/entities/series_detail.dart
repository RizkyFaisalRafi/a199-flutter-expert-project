import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  final String? posterPath;
  final List<Genre> genres;
  final List<int> episodeRunTime;
  final String overview;
  final String originalName;
  final double voteAverage;
  final int id;

  TvSeriesDetail(
      {required this.posterPath,
      required this.genres,
      required this.episodeRunTime,
      required this.overview,
      required this.originalName,
      required this.voteAverage,
      required this.id});

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
