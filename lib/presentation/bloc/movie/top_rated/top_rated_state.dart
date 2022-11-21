part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedEmpty extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedError extends TopRatedState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedHasData extends TopRatedState {
  final List<Movie> result;

  TopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
