import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_series.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeries, GetPopularSeries, GetTopRatedSeries])
void main() {
  late TvSeriesNotifier provider;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    provider = TvSeriesNotifier(
        getTopRatedSeries: mockGetTopRatedSeries,
        getNowPlayingSeries: mockGetNowPlayingSeries,
        getPopularSeries: mockGetPopularSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

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
      id: 1
  );
  final tSeries = <TvSeries>[tTvSeries];

  group('now playing series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeries));
      // act
      provider.fetchNowPlayingSeries();
      // assert
      verify(mockGetNowPlayingSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeries));
      // act
      provider.fetchNowPlayingSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change series when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeries));
      // act
      await provider.fetchNowPlayingSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingSeries, tSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeries));
      // act
      provider.fetchPopularSeries();
      // assert
      expect(provider.popularState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeries));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularState, RequestState.Loaded);
      expect(provider.popularSeries, tSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeries));
      // act
      provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeries));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedState, RequestState.Loaded);
      expect(provider.topRatedSeries, tSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
