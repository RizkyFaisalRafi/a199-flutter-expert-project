import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_series_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_series_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv/series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_detail_notifier.mocks.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetSeriesRecommendation,
  GetTvSeriesWatchListStatus,
  SaveSeriesWatchlist,
  RemoveSeriesWatchlist,
])
void main() {
  late SeriesDetailNotifier provider;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendation mockGetSeriesRecommendations;
  late MockGetTvSeriesWatchListStatus mockGetWatchlistStatus;
  late MockSaveSeriesWatchlist mockSaveWatchlist;
  late MockRemoveSeriesWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendation();
    mockGetWatchlistStatus = MockGetTvSeriesWatchListStatus();
    mockSaveWatchlist = MockSaveSeriesWatchlist();
    mockRemoveWatchlist = MockRemoveSeriesWatchlist();
    provider = SeriesDetailNotifier(
      getSeriesDetail: mockGetSeriesDetail,
      getSeriesRecommendations: mockGetSeriesRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 1;

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

  void _arrangeUsecase() {
    when(mockGetSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    when(mockGetSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSeries));
  }

  group('Get Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockGetSeriesDetail.execute(tId));
      verify(mockGetSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.series, testSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation series when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchSeriesDetail(tId);
          // assert
          expect(provider.seriesState, RequestState.Loaded);
          expect(provider.seriesRecommendations, tSeries);
        });
  });

  group('Get Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockGetSeriesRecommendations.execute(tId));
      expect(provider.seriesRecommendations, tSeries);
    });

    test('should update recommendation state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchSeriesDetail(tId);
          // assert
          expect(provider.recommendationState, RequestState.Loaded);
          expect(provider.seriesRecommendations, tSeries);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testSeriesDetail));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockSaveWatchlist.execute(testSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSeries));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
