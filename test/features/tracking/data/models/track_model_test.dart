import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_model.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final tTrackModel = TrackModel(trackId: 'RP166981607CN', label: 'Новая посылка');

  test(
    'should be a subclass of Track entity',
    () async {
      // arrange
      // act
      // assert
      expect(tTrackModel, isA<Track>());
    },
  );

  group('fromJson', (){
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('track.json'));
        // act
        final result = TrackModel.fromJson(jsonMap);
        // assert
        expect(result, tTrackModel);
      },
    );
  });

  group('toJson', (){
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        // act
        final result = tTrackModel.toJson();
        // assert
        final expectedMap = {
          "trackid": "RP166981607CN",
          "label": "Новая посылка",
        };
        expect(result, expectedMap);
      },
    );
  });
  
}