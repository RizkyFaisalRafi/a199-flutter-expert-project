import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetMovieWatchListStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist
])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetMovieWatchListStatus mockGetMovieWatchListStatus;
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late MockRemoveMovieWatchlist mockRemoveMovieWatchlist;
  late WatchListMovieBloc watchListMovieBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetMovieWatchListStatus = MockGetMovieWatchListStatus();
    mockSaveMovieWatchlist = MockSaveMovieWatchlist();
    mockRemoveMovieWatchlist = MockRemoveMovieWatchlist();
    watchListMovieBloc = WatchListMovieBloc(
        mockGetWatchlistMovies,
        mockGetMovieWatchListStatus,
        mockSaveMovieWatchlist,
        mockRemoveMovieWatchlist
    );
  });

  test('the initial state should be Initial state', () {
    expect(watchListMovieBloc.state, WatchListMovieEmpty());
  });

  group('get watchlist movies', () {
    blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should emit Loading state and then HasData state when watchlist data successfully retrieved',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchListMovie()),
      expect: () => [
        WatchListMovieLoading(),
        WatchListMovieHasData([testWatchlistMovie]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return GetWatchListMovie().props;
      },
    );

    blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should emit Loading state and then Error state when watchlist data failed to retrieved',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchListMovie()),
      expect: () => [
        WatchListMovieLoading(),
        WatchListMovieError('Server Failure'),
      ],
      verify: (bloc) => WatchListMovieLoading(),
    );

    blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchListMovie()),
      expect: () => [
        WatchListMovieLoading(),
        WatchListMovieEmpty(),
      ],
    );
  },
  );

  group('get watchlist status', () {
    blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should be true when the watchlist status is also true',
      build: () {
        when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchListMovieStatus(testMovieDetail.id)),
      expect: () => [
        MovieWatchListAdded(true),
      ],
      verify: (bloc) {
        verify(mockGetMovieWatchListStatus.execute(testMovieDetail.id));
        return GetWatchListMovieStatus(testMovieDetail.id).props;
      },
    );

    blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should be false when the watchlist status is also false',
      build: () {
        when(mockGetMovieWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchListMovieStatus(testMovieDetail.id)),
      expect: () => [
        MovieWatchListAdded(false),
      ],
      verify: (bloc) {
        verify(mockGetMovieWatchListStatus.execute(testMovieDetail.id));
        return GetWatchListMovieStatus(testMovieDetail.id).props;
      },
    );
  },
  );

  group('add and remove watchlist', () {
    blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should update watchlist status when adding watchlist succeeded',
      build: () {
        when(mockSaveMovieWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right("addMessage"));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(AddMovieToWatchList(testMovieDetail)),
      expect: () => [
        MovieWatchListMessage("addMessage"),
      ],
      verify: (bloc) {
        verify(mockSaveMovieWatchlist.execute(testMovieDetail));
        return AddMovieToWatchList(testMovieDetail).props;
      },
    );

    blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should throw failure message status when adding watchlist failed',
      build: () {
        when(mockSaveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
                (_) async =>
                Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(AddMovieToWatchList(testMovieDetail)),
      expect: () => [
        WatchListMovieError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveMovieWatchlist.execute(testMovieDetail));
        return AddMovieToWatchList(testMovieDetail).props;
      },
    );

    blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should update watchlist status when removing watchlist succeeded',
      build: () {
        when(mockRemoveMovieWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right("removeMessage"));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(RemoveMovieFromWatchList(testMovieDetail)),
      expect: () => [
        MovieWatchListMessage("removeMessage"),
      ],
      verify: (bloc) {
        verify(mockRemoveMovieWatchlist.execute(testMovieDetail));
        return RemoveMovieFromWatchList(testMovieDetail).props;
      },
    );

    blocTest<WatchListMovieBloc, WatchListMovieState>(
      'should throw failure message status when removing watchlist failed',
      build: () {
        when(mockRemoveMovieWatchlist.execute(testMovieDetail)).thenAnswer(
                (_) async =>
                Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(RemoveMovieFromWatchList(testMovieDetail)),
      expect: () => [
        WatchListMovieError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveMovieWatchlist.execute(testMovieDetail));
        return RemoveMovieFromWatchList(testMovieDetail).props;
      },
    );
  },
  );
}