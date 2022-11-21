import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movies/now_playing_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../bloc/movie/now_playing/now_playing_bloc.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-movie';

  @override
  _NowPlayingMoviePage createState() => _NowPlayingMoviePage();
}

class _NowPlayingMoviePage extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => // ubah
        // Provider.of<NowPlayingMoviesNotifier>(context, listen: false)
        //     .fetchNowPlayingMovies());
    context.read<NowPlayingBloc>().add(GetNowPlayingMovie()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        // ubah
        child: BlocBuilder<NowPlayingBloc, NowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if(state is NowPlayingError) {
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
