import 'dart:convert';
import 'package:ditonton/data/models/tv/series_model.dart';
import 'package:ditonton/data/models/tv/series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
      name: '',
      genreIds: [1, 1],
      posterPath: '',
      firstAirDate: '',
      backdropPath: '',
      popularity: 0.0,
      voteCount: 0,
      originalName: '',
      originCountry: ["us", "id"],
      overview: '',
      voteAverage: 0,
      id: 1);
  final tTvModelResponseModel =
      TvSeriesResponse(results: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/popular_series.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvModelResponseModel);
    });
  });
}
