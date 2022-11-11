import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  TvSeriesTable(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});

  factory TvSeriesTable.fromEntity(TvSeriesDetail tv) => TvSeriesTable(
      id: tv.id,
      title: tv.originalName,
      posterPath: tv.posterPath,
      overview: tv.overview);

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      overview: map['overview']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview
      };

  TvSeries toEntity() => TvSeries.watchList(
      id: id, overview: overview, posterPath: posterPath, name: title);

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
