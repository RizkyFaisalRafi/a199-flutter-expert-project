part of 'detail_series_bloc.dart';


abstract class DetailSeriesEvent extends Equatable{
  const DetailSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetDetailSeries extends DetailSeriesEvent{
  final int id;

  GetDetailSeries(this.id);

  @override
  List<Object> get props => [id];
}