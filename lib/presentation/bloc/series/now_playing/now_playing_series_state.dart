part of 'now_playing_series_bloc.dart';

abstract class NowPlayingSeriesState extends Equatable{
  const NowPlayingSeriesState();

  @override
  List<Object> get props => [];
}

class NowPlayingSeriesEmpty extends NowPlayingSeriesState {}

class NowPlayingSeriesLoading extends NowPlayingSeriesState{}

class NowPlayingSeriesError extends NowPlayingSeriesState{
  final String message;

  NowPlayingSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingSeriesHasData extends NowPlayingSeriesState{
  final List<TvSeries> result;

  NowPlayingSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}