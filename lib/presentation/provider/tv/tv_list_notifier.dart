import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_series.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesNotifier extends ChangeNotifier {
  var _nowPlayingSeries = <TvSeries>[];

  List<TvSeries> get nowPlayingSeries => _nowPlayingSeries;

  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popularSeries = <TvSeries>[];

  List<TvSeries> get popularSeries => _popularSeries;

  RequestState _popularState = RequestState.Empty;

  RequestState get popularState => _popularState;

  var _topRatedSeries = <TvSeries>[];

  List<TvSeries> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedState = RequestState.Empty;

  RequestState get topRatedState => _topRatedState;

  String _message = '';

  String get message => _message;

  TvSeriesNotifier(
      {required this.getNowPlayingSeries,
      required this.getPopularSeries,
      required this.getTopRatedSeries});

  final GetNowPlayingSeries getNowPlayingSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  Future<void> fetchNowPlayingSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingSeries.execute();
    result.fold((failure) {
      _nowPlayingState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (seriesData) {
      _nowPlayingState = RequestState.Loaded;
      _nowPlayingSeries = seriesData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold((failure) {
      _popularState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (seriesData) {
      _popularState = RequestState.Loaded;
      _popularSeries = seriesData;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold((failure) {
      _topRatedState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (seriesData) {
      _topRatedState = RequestState.Loaded;
      _topRatedSeries = seriesData;
      notifyListeners();
    });
  }
}
