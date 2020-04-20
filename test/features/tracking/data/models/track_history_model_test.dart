import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_history_model.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_history.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tTrackHistoryModel = TrackHistoryModel(
      trackId: 'RP166981607CN',
      timeStamp: '11:29:37 16.04.2020',
      events: [
        EventModel(date: '06.02.2019', activities: [
          ActivityModel(
              time: '18:59',
              zip: '220096',
              city: 'г. Алматы, Первомайский, Илийское шоссе 12',
              name: 'Участок по обработке международной почты',
              depId: '000000',
              status: ['TRANSITSND'],
              depCode: '229900/84/02',
              nondlvReason: null,
              returnReason: null,
              forwardReason: null),
          ActivityModel(
              time: '18:59',
              zip: '900533',
              city: 'г.Алматы - ул.Макатаева 127',
              name: 'Постамат № 53 - ТРЦ Мегапарк',
              depId: '000000',
              status: ['ISSPAY'],
              depCode: '059900/225',
              nondlvReason: null,
              returnReason: null,
              forwardReason: null)
        ]),
        EventModel(date: '05.02.2019', activities: [
          ActivityModel(
              time: '18:43',
              zip: '220096',
              city: 'г. Алматы, Первомайский, Илийское шоссе 12',
              name: 'Участок по обработке международной почты',
              depId: '000000',
              status: ['SRTRPOREG'],
              depCode: '229900/84/02',
              nondlvReason: null,
              returnReason: null,
              forwardReason: null),
        ]),
      ]);

  test(
    'should be a subclass of TrackHistory entity',
    () async {
      // arrange
      // act
      // assert
      expect(tTrackHistoryModel, isA<TrackHistory>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture('track_history.json'));
        // act
        final result = TrackHistoryModel.fromJson(jsonMap);
        // assert
        expect(result, tTrackHistoryModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        // act
        final result = tTrackHistoryModel.toJson();
        // assert
        final expectedMap = {
          'trackid': 'RP166981607CN',
          'timestamp': '11:29:37 16.04.2020',
          'events': [
            {
              'date': '06.02.2019',
              'activity': [
                {
                  'time': '18:59',
                  'zip': '220096',
                  'city': 'г. Алматы, Первомайский, Илийское шоссе 12',
                  'name': 'Участок по обработке международной почты',
                  'x_dep_id': '000000',
                  'status': ['TRANSITSND'],
                  'dep_code': '229900/84/02',
                  'nondlv_reason': null,
                  'return_reason': null,
                  'forward_reason': null
                },
                {
                  'time': '18:59',
                  'zip': '900533',
                  'city': 'г.Алматы - ул.Макатаева 127',
                  'name': 'Постамат № 53 - ТРЦ Мегапарк',
                  'x_dep_id': '000000',
                  'status': ['ISSPAY'],
                  'dep_code': '059900/225',
                  'nondlv_reason': null,
                  'return_reason': null,
                  'forward_reason': null
                }
              ]
            },
            {
              'date': '05.02.2019',
              'activity': [
                {
                  'time': '18:43',
                  'zip': '220096',
                  'city': 'г. Алматы, Первомайский, Илийское шоссе 12',
                  'name': 'Участок по обработке международной почты',
                  'x_dep_id': '000000',
                  'status': ['SRTRPOREG'],
                  'dep_code': '229900/84/02',
                  'nondlv_reason': null,
                  'return_reason': null,
                  'forward_reason': null
                }
              ]
            }
          ]
        };
        expect(result, expectedMap);
      },
    );
  });
}
