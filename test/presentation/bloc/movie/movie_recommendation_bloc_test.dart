import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/recommendations/recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late RecommendationMovieBloc recommendationMovieBloc;

  setUp((){
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieBloc = RecommendationMovieBloc(mockGetMovieRecommendations);
  });

  final id = 1;

  test('the initial state should be empty', () {
    expect(recommendationMovieBloc.state, RecommendationMovieEmpty());
  });

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => Right(testMovieList));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(SetMovieRecommendation(id)),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
      return SetMovieRecommendation(id).props;
    },
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(SetMovieRecommendation(id)),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieError('Server Failure'),
    ],
    verify: (bloc) => RecommendationMovieLoading(),
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => const Right([]));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(SetMovieRecommendation(id)),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieHasData([]),
    ],
  );


}
