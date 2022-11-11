import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_series.dart';
import 'package:flutter/material.dart';

class PopularSeriesNotifier extends ChangeNotifier {
  final GetPopularSeries getPopularSeries;

  PopularSeriesNotifier(this.getPopularSeries);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvSeries> _series = [];

  List<TvSeries> get series => _series;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();

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
