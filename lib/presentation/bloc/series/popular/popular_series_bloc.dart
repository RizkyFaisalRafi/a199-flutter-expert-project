import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';


class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState>{
  final GetPopularSeries _popularSeries;

  PopularSeriesBloc(this._popularSeries) : super(PopularSeriesEmpty()){
    on<GetPopularList>((_, emit) async{
      emit(PopularSeriesLoading());
      final resultPopular = await _popularSeries.execute();

      resultPopular.fold(
              (failure){
            emit(PopularSeriesError(failure.message));
          },
              (data){
            emit(PopularSeriesHasData(data));
          }
      );
    });
  }
}