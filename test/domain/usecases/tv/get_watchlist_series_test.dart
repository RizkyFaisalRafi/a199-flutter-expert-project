import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetWatchlistSeries(mockRepository);
  });

  test('should get list of series from the repository', () async {
    // arrange
    when(mockRepository.getWatchlistSeries())
        .thenAnswer((_) async => Right(testSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testSeriesList));
  });
}
