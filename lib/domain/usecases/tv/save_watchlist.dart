import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class SaveSeriesWatchlist {
  final TvSeriesRepository repository;

  SaveSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail series) {
    return repository.saveSeriesWatchlist(series);
  }
}
