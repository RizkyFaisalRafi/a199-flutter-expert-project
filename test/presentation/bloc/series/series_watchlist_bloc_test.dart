import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_series_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/series/watchlist/watchlist_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesWatchListStatus,
  GetWatchlistSeries,
  SaveSeriesWatchlist,
  RemoveSeriesWatchlist
])
void main() {
  late MockGetTvSeriesWatchListStatus mockGetTvSeriesWatchListStatus;
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late MockSaveSeriesWatchlist mockSaveSeriesWatchlist;
  late MockRemoveSeriesWatchlist mockRemoveSeriesWatchlist;
  late WatchListSeriesBloc watchListSeriesBloc;

  setUp((){
    mockGetTvSeriesWatchListStatus = MockGetTvSeriesWatchListStatus();
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    mockSaveSeriesWatchlist = MockSaveSeriesWatchlist();
    mockRemoveSeriesWatchlist = MockRemoveSeriesWatchlist();
    watchListSeriesBloc = WatchListSeriesBloc(
        mockGetWatchlistSeries,
        mockGetTvSeriesWatchListStatus,
        mockSaveSeriesWatchlist,
        mockRemoveSeriesWatchlist
    );
  });

  test('the initial state should be Initial state', () {
    expect(watchListSeriesBloc.state, WatchListSeriesEmpty());
  });

  group('get watchlist Seriess', () {
    blocTest<WatchListSeriesBloc, WatchListSeriesState>(
      'should emit Loading state and then HasData state when watchlist data successfully retrieved',
      build: () {
        when(mockGetWatchlistSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistSeries]));
        return watchListSeriesBloc;
      },
      act: (bloc) => bloc.add(GetWatchListSeries()),
      expect: () => [
        WatchListSeriesLoading(),
        WatchListSeriesHasData([testWatchlistSeries]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistSeries.execute());
        return GetWatchListSeries().props;
      },
    );

    blocTest<WatchListSeriesBloc, WatchListSeriesState>(
      'should emit Loading state and then Error state when watchlist data failed to retrieved',
      build: () {
        when(mockGetWatchlistSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchListSeriesBloc;
      },
      act: (bloc) => bloc.add(GetWatchListSeries()),
      expect: () => [
        WatchListSeriesLoading(),
        WatchListSeriesError('Server Failure'),
      ],
      verify: (bloc) => WatchListSeriesLoading(),
    );

    blocTest<WatchListSeriesBloc, WatchListSeriesState>(
      'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
      build: () {
        when(mockGetWatchlistSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return watchListSeriesBloc;
      },
      act: (bloc) => bloc.add(GetWatchListSeries()),
      expect: () => [
        WatchListSeriesLoading(),
        WatchListSeriesEmpty(),
      ],
    );
  },
  );

  group('get watchlist status', () {
    blocTest<WatchListSeriesBloc, WatchListSeriesState>(
      'should be true when the watchlist status is also true',
      build: () {
        when(mockGetTvSeriesWatchListStatus.execute(testSeriesDetail.id))
            .thenAnswer((_) async => true);
        return watchListSeriesBloc;
      },
      act: (bloc) => bloc.add(GetWatchListSeriesStatus(testSeriesDetail.id)),
      expect: () => [
        SeriesWatchListAdded(true),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesWatchListStatus.execute(testSeriesDetail.id));
        return GetWatchListSeriesStatus(testSeriesDetail.id).props;
      },
    );

    blocTest<WatchListSeriesBloc, WatchListSeriesState>(
      'should be false when the watchlist status is also false',
      build: () {
        when(mockGetTvSeriesWatchListStatus.execute(testSeriesDetail.id))
            .thenAnswer((_) async => false);
        return watchListSeriesBloc;
      },
      act: (bloc) => bloc.add(GetWatchListSeriesStatus(testSeriesDetail.id)),
      expect: () => [
        SeriesWatchListAdded(false),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesWatchListStatus.execute(testSeriesDetail.id));
        return GetWatchListSeriesStatus(testSeriesDetail.id).props;
      },
    );
  },
  );

  group('add and remove watchlist', () {
    blocTest<WatchListSeriesBloc, WatchListSeriesState>(
      'should update watchlist status when adding watchlist succeeded',
      build: () {
        when(mockSaveSeriesWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => const Right("addMessage"));
        return watchListSeriesBloc;
      },
      act: (bloc) => bloc.add(AddSeriesToWatchList(testSeriesDetail)),
      expect: () => [
        SeriesWatchListMessage("addMessage"),
      ],
      verify: (bloc) {
        verify(mockSaveSeriesWatchlist.execute(testSeriesDetail));
        return AddSeriesToWatchList(testSeriesDetail).props;
      },
    );

    blocTest<WatchListSeriesBloc, WatchListSeriesState>(
      'should throw failure message status when adding watchlist failed',
      build: () {
        when(mockSaveSeriesWatchlist.execute(testSeriesDetail)).thenAnswer(
                (_) async =>
                Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchListSeriesBloc;
      },
      act: (bloc) => bloc.add(AddSeriesToWatchList(testSeriesDetail)),
      expect: () => [
        WatchListSeriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveSeriesWatchlist.execute(testSeriesDetail));
        return AddSeriesToWatchList(testSeriesDetail).props;
      },
    );

    blocTest<WatchListSeriesBloc, WatchListSeriesState>(
      'should update watchlist status when removing watchlist succeeded',
      build: () {
        when(mockRemoveSeriesWatchlist.execute(testSeriesDetail))
            .thenAnswer((_) async => const Right("removeMessage"));
        return watchListSeriesBloc;
      },
      act: (bloc) => bloc.add(RemoveSeriesFromWatchList(testSeriesDetail)),
      expect: () => [
        SeriesWatchListMessage("removeMessage"),
      ],
      verify: (bloc) {
        verify(mockRemoveSeriesWatchlist.execute(testSeriesDetail));
        return RemoveSeriesFromWatchList(testSeriesDetail).props;
      },
    );

    blocTest<WatchListSeriesBloc, WatchListSeriesState>(
      'should throw failure message status when removing watchlist failed',
      build: () {
        when(mockRemoveSeriesWatchlist.execute(testSeriesDetail)).thenAnswer(
                (_) async =>
                Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchListSeriesBloc;
      },
      act: (bloc) => bloc.add(RemoveSeriesFromWatchList(testSeriesDetail)),
      expect: () => [
        WatchListSeriesError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveSeriesWatchlist.execute(testSeriesDetail));
        return RemoveSeriesFromWatchList(testSeriesDetail).props;
      },
    );
  },
  );
}