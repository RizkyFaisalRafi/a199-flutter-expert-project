import 'dart:async';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movies/get_watchlist_movies_status.dart';
import 'package:ditonton/domain/usecases/movies/remove_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movies/save_watchlist_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchListMovieBloc extends Bloc<WatchListMovieEvent, WatchListMovieState>{
  final GetWatchlistMovies _watchlistMovies;
  final GetMovieWatchListStatus _movieWatchListStatus;
  final SaveMovieWatchlist _addMovieWatchList;
  final RemoveMovieWatchlist _removeMovieWatchlist;

  WatchListMovieBloc(this._watchlistMovies, this._movieWatchListStatus, this._addMovieWatchList, this._removeMovieWatchlist) : super(WatchListMovieEmpty()){
    on<GetWatchListMovie>(_getMovieWatchList);
    on<GetWatchListMovieStatus>(_getMovieWatchListStatus);
    on<AddMovieToWatchList>(_movieWatchListAdd);
    on<RemoveMovieFromWatchList>(_movieWatchListRemove);
  }

  FutureOr<void> _getMovieWatchList(
      GetWatchListMovie event, Emitter<WatchListMovieState> state) async {
    state(WatchListMovieLoading());
    final result = await _watchlistMovies.execute();

    result.fold((failure) {
      state(WatchListMovieError(failure.message));
    }, (success) {
      success.isEmpty
          ? state(WatchListMovieEmpty())
          : state(WatchListMovieHasData(success));
    });
  }

  FutureOr<void> _getMovieWatchListStatus(
      GetWatchListMovieStatus event, Emitter<WatchListMovieState> state) async {
    final id = event.id;
    final result = await _movieWatchListStatus.execute(id);
    state(MovieWatchListAdded(result));
  }

  FutureOr<void> _movieWatchListAdd(
      AddMovieToWatchList event, Emitter<WatchListMovieState> state) async {
    final movie = event.movieDetail;

    final result = await _addMovieWatchList.execute(movie);
    result.fold((failure) {
      state(WatchListMovieError(failure.message));
    }, (success) {
      state(MovieWatchListMessage(success));
    });
  }

  FutureOr<void> _movieWatchListRemove(
      RemoveMovieFromWatchList event, Emitter<WatchListMovieState> state) async {
    final movie = event.movieDetail;
    final result = await _removeMovieWatchlist.execute(movie);
    result.fold((failure) {
      state(WatchListMovieError(failure.message));
    }, (success) {
      state(MovieWatchListMessage(success));
    });
  }
}