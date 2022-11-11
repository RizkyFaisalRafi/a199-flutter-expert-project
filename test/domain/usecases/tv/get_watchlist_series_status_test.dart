import 'package:ditonton/domain/usecases/tv/get_watchlist_series_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesWatchListStatus usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesWatchListStatus(mockRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockRepository.isAddedToSeriesWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
