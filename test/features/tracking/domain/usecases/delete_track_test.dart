import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/delete_track.dart';
import 'package:mockito/mockito.dart';

class MockTrackRepository extends Mock implements TrackRepository {}

void main() {
  DeleteTrack useCase;
  MockTrackRepository repository;

  setUp((){
    repository = MockTrackRepository();
    useCase = DeleteTrack(repository);
  });

  final tTrackId = '123';
  final deletedRows = 1;

  test(
    'should remove a track and return a number of deleted rows',
    () async {
      // arrange
      when(repository.deleteTrack(any)).thenAnswer((_) async => Right(deletedRows));
      // act
      final result = await useCase(tTrackId);
      // assert
      expect(result, Right(deletedRows));
      verify(repository.deleteTrack(any));
      verifyNoMoreInteractions(repository);
    },
  );
}