import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_series.dart';
import 'package:ditonton/presentation/bloc/series/now_playing/now_playing_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeries])
void main() {
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late NowPlayingSeriesBloc nowPlayingSeriesBloc;

  setUp((){
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    nowPlayingSeriesBloc = NowPlayingSeriesBloc(mockGetNowPlayingSeries);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingSeriesBloc.state, NowPlayingSeriesEmpty());
  });

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return nowPlayingSeriesBloc;
    },
    act: (bloc) => bloc.add(GetSeriesNowPlaying()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingSeries.execute());
      return GetSeriesNowPlaying().props;
    },
  );

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingSeriesBloc;
    },
    act: (bloc) => bloc.add(GetSeriesNowPlaying()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingSeriesLoading(),
  );

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingSeriesBloc;
    },
    act: (bloc) => bloc.add(GetSeriesNowPlaying()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesHasData([]),
    ],
  );
}