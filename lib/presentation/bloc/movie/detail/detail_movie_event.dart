part of 'detail_movie_bloc.dart';


abstract class DetailMovieEvent extends Equatable{
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class GetDetailMovie extends DetailMovieEvent{
  final int id;

  GetDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}