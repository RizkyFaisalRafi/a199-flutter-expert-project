part of 'top_rated_series_bloc.dart';

abstract class TopRatedSeriesState extends Equatable{
  const TopRatedSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedSeriesEmpty extends TopRatedSeriesState {}

class TopRatedSeriesLoading extends TopRatedSeriesState{}

class TopRatedSeriesError extends TopRatedSeriesState{
  final String message;

  TopRatedSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedSeriesHasData extends TopRatedSeriesState{
  final List<TvSeries> result;

  TopRatedSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}