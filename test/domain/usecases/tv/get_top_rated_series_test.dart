import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTopRatedSeries(mockRepository);
  });

  final tSeries = <TvSeries>[];

  test(
      'should get list of top rated series from the repository when execute function is called',
      () async {
    // arrange
    when(mockRepository.getTopRatedSeries())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}
