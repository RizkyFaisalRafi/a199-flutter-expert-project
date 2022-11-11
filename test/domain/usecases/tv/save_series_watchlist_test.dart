import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveSeriesWatchlist usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = SaveSeriesWatchlist(mockRepository);
  });

  test('should save series to the repository', () async {
    // arrange
    when(mockRepository.saveSeriesWatchlist(testSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockRepository.saveSeriesWatchlist(testSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
