import 'package:ditonton/data/models/tv/series_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
      name: '',
      genreIds: [],
      posterPath: '',
      firstAirDate: '',
      backdropPath: '',
      popularity: 0.0,
      voteCount: 0,
      originalName: '',
      originCountry: [],
      overview: '',
      voteAverage: 0,
      id: 1);

  final tTvSeries = TvSeries(
      name: '',
      genreIds: [],
      posterPath: '',
      firstAirDate: '',
      backdropPath: '',
      popularity: 0.0,
      voteCount: 0,
      originalName: '',
      originCountry: [],
      overview: '',
      voteAverage: 0,
      id: 1);

  test('should be a subclass of Movie entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
