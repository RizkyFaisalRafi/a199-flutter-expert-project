import 'package:ditonton/presentation/bloc/series/now_playing/now_playing_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/state_enum.dart';
import '../../provider/tv/now_playing_series_notifier.dart';
import '../../widgets/series_card_list.dart';

class NowPlayingSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-series';

  @override
  _NowPlayingSeriesPageState createState() => _NowPlayingSeriesPageState();
}

class _NowPlayingSeriesPageState extends State<NowPlayingSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => // ubah
        // Provider.of<NowPlayingSeriesNotifier>(context, listen: false)
        //     .fetchNowPlayingSeries());
    context.read<NowPlayingSeriesBloc>().add(GetSeriesNowPlaying()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // ubah
        child: BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
          builder: (context, state) {
            if (state is NowPlayingSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = state.result[index];
                  return SeriesCard(series);
                },
                itemCount: state.result.length,
              );
            } else if(state is NowPlayingSeriesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }else{
              return Center(
                child: Text('Empty Data'),
              );
            }
          },
        ),

      ),
    );
  }
}
