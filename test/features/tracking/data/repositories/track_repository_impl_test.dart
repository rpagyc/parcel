import 'package:dartz/dartz.dart';
import 'package:kazpost_tracker/core/network/network_info.dart';
import 'package:kazpost_tracker/features/tracking/data/datasources/track_local_datasource.dart';
import 'package:kazpost_tracker/features/tracking/data/datasources/track_remote_datasource.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_details_model.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_history_model.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_model.dart';
import 'package:kazpost_tracker/features/tracking/data/repositories/track_repository_impl.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLocalDataSource extends Mock implements TrackLocalDataSource {}

class MockRemoteDataSource extends Mock implements TrackRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockLocalDataSource mockLocalDataSource;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  TrackRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TrackRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getTrackList', () {
    final tTrackModelList = [
      TrackModel(trackId: '1', label: 'test'),
      TrackModel(trackId: '2', label: 'test')
    ];
    final List<Track> tTracklist = tTrackModelList;
    test(
      'should return local list of tracks',
      () async {
        // arrange
        when(mockLocalDataSource.getTrackList())
            .thenAnswer((_) async => tTrackModelList);
        // act
        final result = await repository.getTrackList();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getTrackList());
        expect(result, equals(Right(tTracklist)));
      },
    );
  });

  group('saveTrack', () {
    final tRef = '123';
    final tTrackModel = TrackModel(trackId: '1', label: 'test');
    test(
      'should save a track',
      () async {
        // arrange
        when(mockLocalDataSource.saveTrack(any)).thenAnswer((_) async => tRef);
        // act
        final result = await repository.saveTrack(tTrackModel);
        // assert
        verify(mockLocalDataSource.saveTrack(tTrackModel));
        expect(result, equals(Right(tRef)));
      },
    );
  });

  group('getTrackDetails', () {
    final tTrackId = '1';
    final tTrackDetailsModel = TrackDetailsModel(trackId: '1', label: 'test');
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getTrackDetails(any))
            .thenAnswer((_) async => tTrackDetailsModel);
        // act
        final result = await repository.getTrackDetails(tTrackId);
        // assert
        verify(mockRemoteDataSource.getTrackDetails(tTrackId));
        expect(result, equals(Right(tTrackDetailsModel)));
      },
    );
  });

  group('getTrackHistory', () {
    final tTrackId = '1';
    final tTrackHistoryModel = TrackHistoryModel(trackId: '1');
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getTrackHistory(any))
            .thenAnswer((_) async => tTrackHistoryModel);
        // act
        final result = await repository.getTrackHistory(tTrackId);
        // assert
        verify(mockRemoteDataSource.getTrackHistory(tTrackId));
        expect(result, equals(Right(tTrackHistoryModel)));
      },
    );
  });

  group('deleteTrack', () {
    final deletedRows = 1;
    final tTrackId = '123';
    test(
      'should delete a track',
      () async {
        // arrange
        when(mockLocalDataSource.deleteTrack(any))
            .thenAnswer((_) async => deletedRows);
        // act
        final result = await repository.deleteTrack(tTrackId);
        // assert
        verify(mockLocalDataSource.deleteTrack(tTrackId));
        expect(result, equals(Right(deletedRows)));
      },
    );
  });
}
