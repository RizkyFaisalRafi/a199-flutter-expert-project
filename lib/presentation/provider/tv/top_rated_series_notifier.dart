import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_series.dart';
import 'package:flutter/material.dart';

class TopRatedSeriesNotifier extends ChangeNotifier {
  final GetTopRatedSeries getTopRatedSeries;

  TopRatedSeriesNotifier(this.getTopRatedSeries);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvSeries> _series = [];

  List<TvSeries> get series => _series;

  String _message = '';

  String get message => _message;

  Future<void> fetchTopRatedSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _series = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
