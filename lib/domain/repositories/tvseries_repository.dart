import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingSeries();

  Future<Either<Failure, List<TvSeries>>> getPopularSeries();

  Future<Either<Failure, List<TvSeries>>> getTopRatedSeries();

  Future<Either<Failure, TvSeriesDetail>> getDetailSeries(int id);

  Future<Either<Failure, List<TvSeries>>> getSeriesRecommendations(int id);

  Future<Either<Failure, List<TvSeries>>> searchSeries(String query);

  Future<Either<Failure, String>> saveSeriesWatchlist(TvSeriesDetail series);

  Future<Either<Failure, String>> removeSeriesWatchlist(TvSeriesDetail series);

  Future<bool> isAddedToSeriesWatchlist(int id);

  Future<Either<Failure, List<TvSeries>>> getWatchlistSeries();
}
