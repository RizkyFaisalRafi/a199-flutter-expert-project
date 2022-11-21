part of 'recommendation_series_bloc.dart';

abstract class RecommendationSeriesEvent extends Equatable{
  const RecommendationSeriesEvent();

  @override
  List<Object> get props => [];
}

class SetSeriesRecommendation extends RecommendationSeriesEvent{
  final int id;

  SetSeriesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}