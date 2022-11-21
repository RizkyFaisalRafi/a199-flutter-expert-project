import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_series_recommendations.dart';
import 'package:ditonton/presentation/bloc/series/recommendations/recommendation_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesRecommendation])
void main() {
  late MockGetSeriesRecommendation mockGetSeriesRecommendation;
  late RecommendationSeriesBloc recommendationSeriesBloc;

  setUp((){
    mockGetSeriesRecommendation = MockGetSeriesRecommendation();
    recommendationSeriesBloc = RecommendationSeriesBloc(mockGetSeriesRecommendation);
  });

  final id = 1;

  test('the initial state should be empty', () {
    expect(recommendationSeriesBloc.state, RecommendationSeriesEmpty());
  });

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetSeriesRecommendation.execute(id))
          .thenAnswer((_) async => Right(testSeriesList));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(SetSeriesRecommendation(id)),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetSeriesRecommendation.execute(id));
      return SetSeriesRecommendation(id).props;
    },
  );

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetSeriesRecommendation.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(SetSeriesRecommendation(id)),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesError('Server Failure'),
    ],
    verify: (bloc) => RecommendationSeriesLoading(),
  );

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetSeriesRecommendation.execute(id))
          .thenAnswer((_) async => const Right([]));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(SetSeriesRecommendation(id)),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesHasData([]),
    ],
  );


}