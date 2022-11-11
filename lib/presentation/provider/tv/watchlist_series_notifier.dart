import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_series.dart';
import 'package:flutter/foundation.dart';

class WatchlistSeriesNotifier extends ChangeNotifier {
  var _watchlistSeries = <TvSeries>[];

  List<TvSeries> get watchlistSeries => _watchlistSeries;

  var _watchlistState = RequestState.Empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  WatchlistSeriesNotifier({required this.getWatchlistSeries});

  final GetWatchlistSeries getWatchlistSeries;

  Future<void> fetchWatchlistSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistSeries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistSeries = moviesData;
        notifyListeners();
      },
    );
  }
}
