import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetPopularSeries {
  final TvSeriesRepository repository;

  GetPopularSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopularSeries();
  }
}
