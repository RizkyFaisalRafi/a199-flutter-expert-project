import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_series_detail.dart';
import 'package:ditonton/presentation/bloc/series/detail/detail_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesDetail])
void main() {
  late MockGetSeriesDetail mockGetSeriesDetail;
  late DetailSeriesBloc detailSeriesBloc;

  setUp((){
    mockGetSeriesDetail = MockGetSeriesDetail();
    detailSeriesBloc = DetailSeriesBloc(mockGetSeriesDetail);
  });

  final id = 1;

  test('the initial state should be empty', () {
    expect(detailSeriesBloc.state, DetailSeriesEmpty());
  });

  blocTest<DetailSeriesBloc, DetailSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetSeriesDetail.execute(id))
          .thenAnswer((_) async => Right(testSeriesDetail));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(GetDetailSeries(id)),
    expect: () => [
      DetailSeriesLoading(),
      DetailSeriesHasData(testSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(id));
      return GetDetailSeries(id).props;
    },
  );

  blocTest<DetailSeriesBloc, DetailSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetSeriesDetail.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(GetDetailSeries(id)),
    expect: () => [
      DetailSeriesLoading(),
      DetailSeriesError('Server Failure'),
    ],
    verify: (bloc) => DetailSeriesLoading(),
  );
}