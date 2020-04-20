import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/features/tracking/data/app_database.dart';
import 'package:kazpost_tracker/features/tracking/data/datasources/track_local_datasource.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_details_model.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_model.dart';
import 'package:mockito/mockito.dart';
import 'package:sembast/sembast.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

class MockStore extends Mock implements StoreRef<String, Map<String, dynamic>> {
}

class MockRecord extends Mock
    implements RecordRef<String, Map<String, dynamic>> {}

void main() {
  TrackLocalDataSource dataSource;
  MockAppDatabase database;
  MockStore tracks;
  MockStore details;
  MockStore history;

  setUp(() {
    database = MockAppDatabase();
    tracks = MockStore();
    details = MockStore();
    history = MockStore();
    dataSource = TrackLocalDataSourceImpl(
      database: database,
      tracks: tracks,
      details: details,
      history: history,
    );
  });

  group('getTrackList', () {
    final List<RecordSnapshot<String, Map<String, dynamic>>> tRecords = [];
    final List<TrackModel> tTrackList = [];
    test(
      'should return a list of tracks',
      () async {
        // arrange
        when(tracks.find(any)).thenAnswer((_) async => Future.value(tRecords));
        // act
        final result = await dataSource.getTrackList();
        // assert
        verify(tracks.find(any));
        expect(result, tTrackList);
      },
    );
  });

  group('saveTrack', () {
    final tRef = '123';
    final tTrackModel = TrackModel(trackId: '1', label: 'test');
    final tRecord = MockRecord();
    test(
      'should save a track',
      () async {
        // arrange
        when(tracks.record(any)).thenReturn(tRecord);
        when(tRecord.put(any, tTrackModel.toJson()))
            .thenAnswer((_) async => Future.value(tRef));
        // act
        final result = await dataSource.saveTrack(tTrackModel);
        // assert
        verify(tRecord.put(any, tTrackModel.toJson()));
        expect(result, tRef);
      },
    );
  });

  group('deleteTrack', () {
    final int deletedRows = 1;
    final String tTrackId = '123';
    test(
      'should delete a track',
      () async {
        // arrange
        when(tracks.delete(any, finder: anyNamed('finder')))
            .thenAnswer((_) async => Future.value(deletedRows));
        // act
        final result = await dataSource.deleteTrack(tTrackId);
        // assert
        verify(tracks.delete(any, finder: anyNamed('finder')));
        expect(result, deletedRows);
      },
    );
  });

  group('getTrackDetails', (){
    final tTrackDetails = TrackDetailsModel(trackId: '123', label: 'test');
    final tRecord = MockRecord();
    final tTrackId = '123';
    test(
      'should return track details',
      () async {
        // arrange
        when(details.record(any)).thenReturn(tRecord);
        when(tRecord.get(any)).thenAnswer((_) async => Future.value(tTrackDetails.toJson()));
        // act
        final result = await dataSource.getTrackDetails(tTrackId);
        // assert
        expect(result, tTrackDetails);
      },
    );
  });
}
