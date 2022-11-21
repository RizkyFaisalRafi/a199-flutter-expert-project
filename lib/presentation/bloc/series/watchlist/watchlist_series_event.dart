part of 'watchlist_series_bloc.dart';

abstract class WatchListSeriesEvent extends Equatable{}

class GetWatchListSeries extends WatchListSeriesEvent{

  @override
  List<Object> get props => [];
}

class GetWatchListSeriesStatus extends WatchListSeriesEvent{
  final int id;

  GetWatchListSeriesStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddSeriesToWatchList extends WatchListSeriesEvent{
  final TvSeriesDetail tvSeriesDetail;

  AddSeriesToWatchList(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class RemoveSeriesFromWatchList extends WatchListSeriesEvent{
  final TvSeriesDetail tvSeriesDetail;

  RemoveSeriesFromWatchList(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}