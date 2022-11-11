import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetWatchlistSeries {
  final TvSeriesRepository _repository;

  GetWatchlistSeries(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
