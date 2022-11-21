part of 'watchlist_movie_bloc.dart';

abstract class WatchListMovieEvent extends Equatable{}

class GetWatchListMovie extends WatchListMovieEvent{

  @override
  List<Object> get props => [];
}

class GetWatchListMovieStatus extends WatchListMovieEvent{
  final int id;

  GetWatchListMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieToWatchList extends WatchListMovieEvent{
  final MovieDetail movieDetail;

  AddMovieToWatchList(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMovieFromWatchList extends WatchListMovieEvent{
  final MovieDetail movieDetail;

  RemoveMovieFromWatchList(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}