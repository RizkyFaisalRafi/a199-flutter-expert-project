
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_series.dart';
import 'package:ditonton/presentation/bloc/series/popular/popular_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late PopularSeriesBloc popularBloc;
  late MockGetPopularSeries mockGetPopularSeries;

  setUp((){
    mockGetPopularSeries = MockGetPopularSeries();
    popularBloc = PopularSeriesBloc(mockGetPopularSeries);
  });


  test('the initial state should be empty', () {
    expect(popularBloc.state, PopularSeriesEmpty());
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return popularBloc;
    },
    act: (bloc) => bloc.add(GetPopularList()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularSeries.execute());
      return GetPopularList().props;
    },
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(GetPopularList()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesError('Server Failure'),
    ],
    verify: (bloc) => PopularSeriesLoading(),
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return popularBloc;
    },
    act: (bloc) => bloc.add(GetPopularList()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesHasData([]),
    ],
  );
}
