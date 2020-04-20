import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_details.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_details.dart';
import 'package:mockito/mockito.dart';

class MockTrackRepository extends Mock implements TrackRepository {}

void main() {
  GetTrackDetails usecase;
  MockTrackRepository mockTrackRepository;

  setUp(() {
    mockTrackRepository = MockTrackRepository();
    usecase = GetTrackDetails(mockTrackRepository);
  });

  final tTrackId = '123';
  final tTrackDetails = TrackDetails();

  test(
    'should get track details from the repository',
    () async {
      // arrange
      when(mockTrackRepository.getTrackDetails(any))
          .thenAnswer((_) async => Right(tTrackDetails));
      // act
      final result = await usecase(tTrackId);
      // assert
      expect(result, Right(tTrackDetails));
      verify(mockTrackRepository.getTrackDetails(any));
      verifyNoMoreInteractions(mockTrackRepository);
    },
  );
}
