import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int id;
  String? name;
  List<String>? originCountry;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  TvSeries(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genreIds,
      required this.id,
      required this.name,
      required this.originCountry,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});

  TvSeries.watchList(
      {required this.id,
      required this.overview,
      required this.posterPath,
      required this.name});

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originCountry,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount
      ];
}
