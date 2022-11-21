
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_series_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_series_event.dart';
part 'detail_series_state.dart';

class DetailSeriesBloc extends Bloc<DetailSeriesEvent, DetailSeriesState>{
  final GetSeriesDetail _seriesDetail;


  DetailSeriesBloc(this._seriesDetail) : super(DetailSeriesEmpty()){
    on<GetDetailSeries>((event, emit) async{
      final id = event.id;

      emit(DetailSeriesLoading());
      final result = await _seriesDetail.execute(id);

      result.fold(
              (failure){
            emit(DetailSeriesError(failure.message));
          },
              (data){
            emit(DetailSeriesHasData(data));
          }
      );
    });
  }
}