import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';


class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState>{
  final GetTopRatedMovies _topRatedMovies;

  TopRatedBloc(this._topRatedMovies) : super(TopRatedEmpty()){
    on<TopRatedMovie>((_, emit) async{
      emit(TopRatedLoading());
      final resultTopRated = await _topRatedMovies.execute();

      resultTopRated.fold(
              (failure){
            emit(TopRatedError(failure.message));
          },
              (data){
            emit(TopRatedHasData(data));
          }
      );
    });
  }
}