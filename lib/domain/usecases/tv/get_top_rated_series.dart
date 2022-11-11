import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetTopRatedSeries {
  final TvSeriesRepository repository;

  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedSeries();
  }
}
