import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationMovieBloc extends Bloc<RecommendationMovieEvent, RecommendationMovieState>{
  final GetMovieRecommendations _movieRecommendations;

  RecommendationMovieBloc(this._movieRecommendations) : super(RecommendationMovieEmpty()){
    on<SetMovieRecommendation>((event, emit) async{
      final id = event.id;

      emit(RecommendationMovieLoading());
      final result = await _movieRecommendations.execute(id);

      result.fold(
              (failure){
            emit(RecommendationMovieError(failure.message));
          },
              (data){
            emit(RecommendationMovieHasData(data));
          }
      );
    });
  }
}