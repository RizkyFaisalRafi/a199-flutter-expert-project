import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/get_now_playing_movies.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';


class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState>{
  final GetNowPlayingMovies _nowPlayingMovies;

  NowPlayingBloc(this._nowPlayingMovies) : super(NowPlayingEmpty()){
    on<GetNowPlayingMovie>((_, emit) async{
      emit(NowPlayingLoading());
      final resultNowPlaying = await _nowPlayingMovies.execute();

      resultNowPlaying.fold(
              (failure){
            emit(NowPlayingError(failure.message));
          },
              (data){
            emit(NowPlayingHasData(data));
          }
      );
    });
  }
}