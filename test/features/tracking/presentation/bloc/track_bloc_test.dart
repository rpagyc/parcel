import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/core/error/failures.dart';
import 'package:kazpost_tracker/core/usecases/usecase.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/delete_track.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_details.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_history.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_list.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/save_track.dart';
import 'package:kazpost_tracker/features/tracking/presentation/bloc/track_bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetTrackList extends Mock implements GetTrackList {}

class MockSaveTrack extends Mock implements SaveTrack {}

class MockGetTrackDetails extends Mock implements GetTrackDetails {}

class MockGetTrackHistory extends Mock implements GetTrackHistory {}

class MockDeleteTrack extends Mock implements DeleteTrack {}

void main() {
  TrackBloc bloc;
  MockGetTrackList mockGetTrackList;
  MockSaveTrack mockSaveTrack;
  MockGetTrackDetails mockGetTrackDetails;
  MockGetTrackHistory mockGetTrackHistory;
  MockDeleteTrack mockDeleteTrack;

  setUp(() {
    mockGetTrackList = MockGetTrackList();
    mockSaveTrack = MockSaveTrack();
    mockGetTrackHistory = MockGetTrackHistory();
    mockGetTrackDetails = MockGetTrackDetails();
    mockDeleteTrack = MockDeleteTrack();
    bloc = TrackBloc(
        getTrackList: mockGetTrackList,
        saveTrack: mockSaveTrack,
        getTrackDetails: mockGetTrackDetails,
        getTrackHistory: mockGetTrackHistory,
        deleteTrack: mockDeleteTrack);
  });

  test(
    'initialState should be Empty',
    () async {
      // arrange
      // act
      // assert
      expect(bloc.initialState, equals(Empty()));
    },
  );

  group('GetTrackListEvent', () {
    final tTrackList = [Track(trackId: '1', label: 'test')];
    test(
      'should get data from the getTrackList use case',
      () async {
        // arrange
        when(mockGetTrackList(any)).thenAnswer((_) async => Right(tTrackList));
        // act
        bloc.add(GetTrackListEvent());
        await untilCalled(mockGetTrackList(any));
        // assert
        verify(mockGetTrackList(NoParams()));
      },
    );
    blocTest(
      'should emit [Loading, TrackListLoaded] when the data is gotten successfully',
      build: () async {
        when(mockGetTrackList(any)).thenAnswer((_) async => Right(tTrackList));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTrackListEvent()),
      expect: [Loading(), TrackListLoaded(trackList: tTrackList)]
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails',
      build: () async {
        when(mockGetTrackList(any)).thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTrackListEvent()),
      expect: [Loading(), Error(message: 'Cache failure')]
    );

  });

  group('SaveTrackEvent', (){
    final tRef = '1';
    final tTrack = Track(label: 'test', trackId: '1');
    final tTrackList = [tTrack];
    test(
      'should save data by the saveTrack use case',
      () async {
        // arrange
        when(mockSaveTrack(any)).thenAnswer((_) async => Right(tRef));
        // act
        bloc.add(SaveTrackEvent(track: tTrack));
        await untilCalled(mockSaveTrack(any));
        // assert
        verify(mockSaveTrack(tTrack));
      },
    );

    blocTest(
      'should emit [Loading, TrackListLoaded] when the data is saved successfully',
      build: () async {
        when(mockSaveTrack(any)).thenAnswer((_) async => Right(tRef));
        when(mockGetTrackList(any)).thenAnswer((_) async => Right(tTrackList));
        return bloc;
      },
      act: (bloc) => bloc.add(SaveTrackEvent()),
      expect: [Loading(), TrackListLoaded(trackList: tTrackList)]
    );
  });

  group('DeleteTrackEvent', (){
    final deletedRows = 1;
    final tTrackId  = '123';
    final tTrack = Track(label: 'test', trackId: '1');
    final tTrackList = [tTrack];
    test(
      'should delete data by the deleteTrack use case',
      () async {
        // arrange
        when(mockDeleteTrack(any)).thenAnswer((_) async => Right(deletedRows));
        // act
        bloc.add(DeleteTrackEvent(tTrackId));
        await untilCalled(mockDeleteTrack(any));
        // assert
        verify(mockDeleteTrack(tTrackId));
      },
    );

    blocTest(
      'should emit [Loading, TrackListLoaded] when the track is deleted successfully',
      build: () async {
        when(mockDeleteTrack(any)).thenAnswer((_) async => Right(deletedRows));
        when(mockGetTrackList(any)).thenAnswer((_) async => Right(tTrackList));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteTrackEvent(tTrackId)),
      expect: [Loading(), TrackListLoaded(trackList: tTrackList)]
    );
  });
}
