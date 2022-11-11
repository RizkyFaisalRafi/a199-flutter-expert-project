import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv/tvseries_table.dart';

abstract class SeriesLocalDataSource {
  Future<String> insertSeriesWatchlist(TvSeriesTable series);

  Future<String> removeSeriesWatchlist(TvSeriesTable series);

  Future<TvSeriesTable?> getSeriesById(int id);

  Future<List<TvSeriesTable>> getWatchlistSeries();
}

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  SeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertSeriesWatchlist(TvSeriesTable series) async {
    try {
      await databaseHelper.insertSeriesWatchlist(series);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeSeriesWatchlist(TvSeriesTable series) async {
    try {
      await databaseHelper.removeSeriesWatchlist(series);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getSeriesById(int id) async {
    final result = await databaseHelper.getSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistSeries() async {
    final result = await databaseHelper.getWatchlistSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }
}
