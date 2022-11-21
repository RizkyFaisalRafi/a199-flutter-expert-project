import 'dart:async';

import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_series_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_series_event.dart';
part 'watchlist_series_state.dart';

class WatchListSeriesBloc extends Bloc<WatchListSeriesEvent, WatchListSeriesState>{
  final GetWatchlistSeries _watchlistSeries;
  final GetTvSeriesWatchListStatus _seriesWatchListStatus;
  final SaveSeriesWatchlist _addSeriesWatchList;
  final RemoveSeriesWatchlist _removeSeriesWatchlist;

  WatchListSeriesBloc(this._watchlistSeries, this._seriesWatchListStatus, this._addSeriesWatchList, this._removeSeriesWatchlist) : super(WatchListSeriesEmpty()){
    on<GetWatchListSeries>(_getSeriesWatchList);
    on<GetWatchListSeriesStatus>(_getSeriesWatchListStatus);
    on<AddSeriesToWatchList>(_seriesWatchListAdd);
    on<RemoveSeriesFromWatchList>(_seriesWatchListRemove);
  }

  FutureOr<void> _getSeriesWatchList(
      GetWatchListSeries event, Emitter<WatchListSeriesState> state) async {
    state(WatchListSeriesLoading());
    final result = await _watchlistSeries.execute();

    result.fold((failure) {
      state(WatchListSeriesError(failure.message));
    }, (success) {
      success.isEmpty
          ? state(WatchListSeriesEmpty())
          : state(WatchListSeriesHasData(success));
    });
  }

  FutureOr<void> _getSeriesWatchListStatus(
      GetWatchListSeriesStatus event, Emitter<WatchListSeriesState> state) async {
    final id = event.id;
    final result = await _seriesWatchListStatus.execute(id);
    state(SeriesWatchListAdded(result));
  }

  FutureOr<void> _seriesWatchListAdd(
      AddSeriesToWatchList event, Emitter<WatchListSeriesState> state) async {
    final series = event.tvSeriesDetail;
    final result = await _addSeriesWatchList.execute(series);
    result.fold((failure) {
      state(WatchListSeriesError(failure.message));
    }, (success) {
      state(SeriesWatchListMessage(success));
    });
  }

  FutureOr<void> _seriesWatchListRemove(
      RemoveSeriesFromWatchList event, Emitter<WatchListSeriesState> state) async {
    final series = event.tvSeriesDetail;
    final result = await _removeSeriesWatchlist.execute(series);
    result.fold((failure) {
      state(WatchListSeriesError(failure.message));
    }, (success) {
      state(SeriesWatchListMessage(success));
    });
  }
}