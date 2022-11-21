import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/tv/get_series_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_series_event.dart';
part 'recommendation_series_state.dart';

class RecommendationSeriesBloc extends Bloc<RecommendationSeriesEvent, RecommendationSeriesState>{
  final GetSeriesRecommendation _seriesRecommendations;

  RecommendationSeriesBloc(this._seriesRecommendations) : super(RecommendationSeriesEmpty()){
    on<SetSeriesRecommendation>((event, emit) async{
      final id = event.id;

      emit(RecommendationSeriesLoading());
      final result = await _seriesRecommendations.execute(id);

      result.fold(
              (failure){
            emit(RecommendationSeriesError(failure.message));
          },
              (data){
            emit(RecommendationSeriesHasData(data));
          }
      );
    });
  }
}