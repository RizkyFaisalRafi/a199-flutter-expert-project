import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetTvSeriesWatchListStatus {
  final TvSeriesRepository repository;

  GetTvSeriesWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToSeriesWatchlist(id);
  }
}
