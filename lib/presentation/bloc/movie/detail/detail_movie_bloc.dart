import 'package:ditonton/domain/usecases/movies/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState>{
  final GetMovieDetail _movieDetail;


  DetailMovieBloc(this._movieDetail) : super(DetailMovieEmpty()){
    on<GetDetailMovie>((event, emit) async{
      final id = event.id;



      emit(DetailMovieLoading());
      final result = await _movieDetail.execute(id);

      result.fold(
              (failure){
            emit(DetailMovieError(failure.message));
          },
              (data){
            emit(DetailMovieHasData(data));
          }
      );
    });
  }
}