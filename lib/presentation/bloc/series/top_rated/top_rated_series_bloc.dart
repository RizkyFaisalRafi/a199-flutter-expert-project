import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';


class TopRatedSeriesBloc extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState>{
  final GetTopRatedSeries _topRatedSeries;

  TopRatedSeriesBloc(this._topRatedSeries) : super(TopRatedSeriesEmpty()){
    on<TopRatedSeries>((_, emit) async{
      emit(TopRatedSeriesLoading());
      final resultTopRated = await _topRatedSeries.execute();

      resultTopRated.fold(
              (failure){
            emit(TopRatedSeriesError(failure.message));
          },
              (data){
            emit(TopRatedSeriesHasData(data));
          }
      );
    });
  }
}