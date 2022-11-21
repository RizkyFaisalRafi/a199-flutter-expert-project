part of 'search_series_bloc.dart';

abstract class SearchSeriesEvent extends Equatable{
  const SearchSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnQuerySeriesChanged extends SearchSeriesEvent{
  final String query;

  OnQuerySeriesChanged(this.query);

  @override
  List<Object> get props => [query];
}