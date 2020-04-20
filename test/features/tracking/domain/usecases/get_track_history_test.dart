import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_history.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_history.dart';
import 'package:mockito/mockito.dart';

class MockTrackRepository extends Mock implements TrackRepository {}

void main() {
  GetTrackHistory usecase;
  MockTrackRepository mockTrackRepository;

  setUp(() {
    mockTrackRepository = MockTrackRepository();
    usecase = GetTrackHistory(mockTrackRepository);
  });

  final tTrackId = '123';
  final tTrackHistory = TrackHistory();

  test(
    'should get track history from the repository',
    () async {
      // arrange
      when(mockTrackRepository.getTrackHistory(any))
          .thenAnswer((_) async => Right(tTrackHistory));
      // act
      final result = await usecase(tTrackId);
      // assert
      expect(result, Right(tTrackHistory));
      verify(mockTrackRepository.getTrackHistory(any));
      verifyNoMoreInteractions(mockTrackRepository);
    },
  );
}
