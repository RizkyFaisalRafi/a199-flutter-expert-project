part of 'watchlist_movie_bloc.dart';


abstract class WatchListMovieState extends Equatable{}

class WatchListMovieEmpty extends WatchListMovieState {
  @override
  List<Object> get props => [];
}

class WatchListMovieLoading extends WatchListMovieState{
  @override
  List<Object> get props => [];
}

class WatchListMovieError extends WatchListMovieState{
  final String message;

  WatchListMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchListMovieHasData extends WatchListMovieState{
  final List<Movie> result;

  WatchListMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieWatchListAdded extends WatchListMovieState{
  final bool isAdded;

  MovieWatchListAdded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class MovieWatchListMessage extends WatchListMovieState{
  final String message;

  MovieWatchListMessage(this.message);

  @override
  List<Object> get props => [message];
}