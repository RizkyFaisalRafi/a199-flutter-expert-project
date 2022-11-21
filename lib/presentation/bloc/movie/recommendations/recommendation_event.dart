part of 'recommendation_bloc.dart';

abstract class RecommendationMovieEvent extends Equatable{
  const RecommendationMovieEvent();

  @override
  List<Object> get props => [];
}

class SetMovieRecommendation extends RecommendationMovieEvent{
  final int id;

  SetMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}