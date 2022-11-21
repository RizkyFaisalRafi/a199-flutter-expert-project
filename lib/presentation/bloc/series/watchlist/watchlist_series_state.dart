part of 'watchlist_series_bloc.dart';


abstract class WatchListSeriesState extends Equatable{}

class WatchListSeriesEmpty extends WatchListSeriesState {
  @override
  List<Object> get props => [];
}

class WatchListSeriesLoading extends WatchListSeriesState{
  @override
  List<Object> get props => [];
}

class WatchListSeriesError extends WatchListSeriesState{
  final String message;

  WatchListSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchListSeriesHasData extends WatchListSeriesState{
  final List<TvSeries> result;

  WatchListSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SeriesWatchListAdded extends WatchListSeriesState{
  final bool isAdded;

  SeriesWatchListAdded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class SeriesWatchListMessage extends WatchListSeriesState{
  final String message;

  SeriesWatchListMessage(this.message);

  @override
  List<Object> get props => [message];
}