import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main(){
  late MockGetTopRatedMovies mockTopRated;
  late TopRatedBloc topRatedBloc;
  
  setUp((){
    mockTopRated = MockGetTopRatedMovies();
    topRatedBloc = TopRatedBloc(mockTopRated);
  });

  test('the initial state should be empty', () {
    expect(topRatedBloc.state, TopRatedEmpty());
  });

  blocTest<TopRatedBloc, TopRatedState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockTopRated.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(TopRatedMovie()),
    expect: () => [
      TopRatedLoading(),
      TopRatedHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockTopRated.execute());
      return TopRatedMovie().props;
    },
  );

  blocTest<TopRatedBloc, TopRatedState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(TopRatedMovie()),
    expect: () => [
      TopRatedLoading(),
      TopRatedError('Server Failure'),
    ],
    verify: (bloc) => TopRatedLoading(),
  );

  blocTest<TopRatedBloc, TopRatedState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockTopRated.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(TopRatedMovie()),
    expect: () => [
      TopRatedLoading(),
      TopRatedHasData([]),
    ],
  );

}