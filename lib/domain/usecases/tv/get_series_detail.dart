import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetSeriesDetail {
  final TvSeriesRepository repository;

  GetSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(id) {
    return repository.getDetailSeries(id);
  }
}
