import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/search_series.dart';
import 'package:ditonton/presentation/bloc/series/search/search_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late MockSearchSeries mockSearchSeries;
  late SearchSeriesBloc searchSeriesBloc;

  final tQuery = 'spiderman';

  setUp((){
    mockSearchSeries = MockSearchSeries();
    searchSeriesBloc = SearchSeriesBloc(mockSearchSeries);
  });

  test('initial state should be empty', (){
    expect(searchSeriesBloc.state, SearchSeriesEmpty());
  });

  blocTest<SearchSeriesBloc, SearchSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: (){
        when(mockSearchSeries.execute(tQuery))
            .thenAnswer((_) async => Right(testSeriesList));
        return searchSeriesBloc;
      },
      act: (bloc) => bloc.add(OnQuerySeriesChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchSeriesLoading(),
        SearchSeriesHasData(testSeriesList),
      ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery));
      }
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: (){
        when(mockSearchSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchSeriesBloc;
      },
      act: (bloc) => bloc.add(OnQuerySeriesChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchSeriesLoading(),
        SearchSeriesError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery));
      }
  );

}