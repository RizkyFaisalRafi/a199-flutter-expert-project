import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesDetail usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetSeriesDetail(mockRepository);
  });

  final tId = 1;

  test(
      'should get detail series from the repository when execute function is called',
      () async {
    // arrange
    when(mockRepository.getDetailSeries(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testSeriesDetail));
  });
}
