import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/features/tracking/data/datasources/track_remote_datasource.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_details_model.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_history_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  TrackRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TrackRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getTrackDetails', () {
    final tTrackId = '123';
    final tTrackDetailsModel = TrackDetailsModel.fromJson(jsonDecode(fixture('track.json')));
    test(
      '''should perform a GET request on a URL with a trackId being 
      the endpoint and with "application/json; charset=utf-8" header''',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(fixture('track.json'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            }));
        // act
        dataSource.getTrackDetails(tTrackId);
        // assert
        verify(mockHttpClient.get(
          'http://track.kazpost.kz/api/v2/$tTrackId',
          headers: {
            'content-type': 'application/json; charset=utf-8',
          },
        ));
      },
    );

    test(
      'should return TrackDetails when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(fixture('track.json'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            }));
        // act
        final result = await dataSource.getTrackDetails(tTrackId);
        // assert
        expect(result, equals(tTrackDetailsModel));
      },
    );
  });

  group('getTrackHistory', () {
    final tTrackId = '123';
    final tTrackDetailsModel = TrackHistoryModel.fromJson(jsonDecode(fixture('track_history.json')));
    test(
      '''should perform a GET request on a URL with a trackId being 
      the endpoint and with "application/json; charset=utf-8" header''',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(fixture('track_history.json'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            }));
        // act
        dataSource.getTrackHistory(tTrackId);
        // assert
        verify(mockHttpClient.get(
          'http://track.kazpost.kz/api/v2/$tTrackId/events',
          headers: {
            'content-type': 'application/json; charset=utf-8',
          },
        ));
      },
    );

    test(
      'should return TrackHistory when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(fixture('track_history.json'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            }));
        // act
        final result = await dataSource.getTrackHistory(tTrackId);
        // assert
        expect(result, equals(tTrackDetailsModel));
      },
    );
  });

}
