import 'package:ditonton/data/models/movie/movie_table.dart';
import 'package:ditonton/data/models/tv/tvseries_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testSeriesDetail = TvSeriesDetail(
    posterPath: '',
    genres: [Genre(id: 1, name: '')],
    episodeRunTime: [0, 0],
    overview: '',
    originalName: '',
    voteAverage: 0.0,
    id: 1, runtime: 0);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistSeries = TvSeries.watchList(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'title',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesTable = TvSeriesTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final tTvSeriesModel = TvSeries(
    name: '',
    genreIds: [1, 1],
    posterPath: '',
    firstAirDate: '',
    backdropPath: '',
    popularity: 0.0,
    voteCount: 0,
    originalName: '',
    originCountry: ["us", "id"],
    overview: '',
    voteAverage: 0,
    id: 1);

final testSeriesList = [tTvSeriesModel];
