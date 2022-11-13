import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movies/now_playing_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-movie';

  @override
  _NowPlayingMoviePage createState() => _NowPlayingMoviePage();
}

class _NowPlayingMoviePage extends State<NowPlayingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingMoviesNotifier>(context, listen: false)
            .fetchNowPlayingMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return MovieCard(movie);
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
