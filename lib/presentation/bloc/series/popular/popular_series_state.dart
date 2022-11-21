part of 'popular_series_bloc.dart';

abstract class PopularSeriesState extends Equatable{
  const PopularSeriesState();

  @override
  List<Object> get props => [];
}

class PopularSeriesEmpty extends PopularSeriesState {}

class PopularSeriesLoading extends PopularSeriesState{}

class PopularSeriesError extends PopularSeriesState{
  final String message;

  PopularSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularSeriesHasData extends PopularSeriesState{
  final List<TvSeries> result;

  PopularSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}