import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/core/usecases/usecase.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_list.dart';
import 'package:mockito/mockito.dart';

class MockTrackRepository extends Mock implements TrackRepository {}

void main() {
  GetTrackList usecase;
  MockTrackRepository mockTrackRepository;

  setUp(() {
    mockTrackRepository = MockTrackRepository();
    usecase = GetTrackList(mockTrackRepository);
  });

  final tTrackList = [
    Track(trackId: '1', label: 'a'),
    Track(trackId: '2', label: 'b')
  ];

  test(
    'should get list of tracks from the repository',
    () async {
      // arrange
      when(mockTrackRepository.getTrackList())
          .thenAnswer((_) async => Right(tTrackList));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tTrackList));
      verify(mockTrackRepository.getTrackList());
      verifyNoMoreInteractions(mockTrackRepository);
    },
  );
}
