part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularEmpty extends PopularState {}

class PopularLoading extends PopularState {}

class PopularError extends PopularState {
  final String message;

  PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularHasData extends PopularState {
  final List<Movie> result;

  PopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
