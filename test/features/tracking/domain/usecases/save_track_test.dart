import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/save_track.dart';
import 'package:mockito/mockito.dart';

class MockTrackRepository extends Mock implements TrackRepository {}

void main() {
  SaveTrack usecase;
  MockTrackRepository repository;

  setUp(() {
    repository = MockTrackRepository();
    usecase = SaveTrack(repository);
  });

  final tTrack = Track(trackId: '123', label: 'test');
  final tReference = 'abc';

  test(
    'should save a track and return a reference',
    () async {
      // arrange
      when(repository.saveTrack(any))
          .thenAnswer((_) async => Right(tReference));
      // act
      var result = await usecase(tTrack);
      // assert
      expect(result, Right(tReference));
      verify(repository.saveTrack(any));
      verifyNoMoreInteractions(repository);
    },
  );
}
