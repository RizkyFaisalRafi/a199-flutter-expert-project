import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_series_event.dart';

part 'now_playing_series_state.dart';

class NowPlayingSeriesBloc
    extends Bloc<NowPlayingSeriesEvent, NowPlayingSeriesState> {
  final GetNowPlayingSeries _nowPlayingSeries;

  NowPlayingSeriesBloc(this._nowPlayingSeries)
      : super(NowPlayingSeriesEmpty()) {
    on<GetSeriesNowPlaying>((_, emit) async {
      emit(NowPlayingSeriesLoading());
      final resultNowPlaying = await _nowPlayingSeries.execute();

      resultNowPlaying.fold((failure) {
        emit(NowPlayingSeriesError(failure.message));
      }, (data) {
        emit(NowPlayingSeriesHasData(data));
      });
    });
  }
}
