import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class SearchSeries {
  final TvSeriesRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
