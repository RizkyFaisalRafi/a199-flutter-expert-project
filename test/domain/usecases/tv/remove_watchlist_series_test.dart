import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveSeriesWatchlist usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = RemoveSeriesWatchlist(mockRepository);
  });

  test('should remove watchlist series from repository', () async {
    // arrange
    when(mockRepository.removeSeriesWatchlist(testSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockRepository.removeSeriesWatchlist(testSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
