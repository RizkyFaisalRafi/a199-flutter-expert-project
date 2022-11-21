import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'popular_event.dart';
part 'popular_state.dart';


class PopularBloc extends Bloc<PopularEvent, PopularState>{
  final GetPopularMovies _popularMovies;

  PopularBloc(this._popularMovies) : super(PopularEmpty()){
    on<GetPopularMovie>((_, emit) async{
      emit(PopularLoading());
      final resultPopular = await _popularMovies.execute();

      resultPopular.fold(
              (failure){
            emit(PopularError(failure.message));
          },
              (data){
            emit(PopularHasData(data));
          }
      );
    });
  }
}