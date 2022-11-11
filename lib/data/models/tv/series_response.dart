import 'package:ditonton/data/models/tv/series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> results;

  TvSeriesResponse({required this.results});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        results: List<TvSeriesModel>.from((json["results"] as List)
            .map((x) => TvSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [results];
}
