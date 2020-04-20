import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_details_model.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_details.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tTrackDetailsModel = TrackDetailsModel(
      category: 'Заказное',
      deliveryMethod: 'Авиа',
      label: 'Новая посылка',
      last: LastModel(
          address: 'г.Алматы - ул.Макатаева 127',
          date: '2019-02-03 23:14:21.454',
          depName: 'Постамат № 53 - ТРЦ Мегапарк',
          index: '900533'),
      packageType: 'Мелкий пакет СНГ/ДЗ',
      receiver: ReceiverModel(
          name: 'SHAKIROV   ROMAN',
          address: 'ALMATY    MAKATAEVA   127',
          country: 'KZ'),
      sender: SenderModel(name: '1', address: '1', country: 'CN'),
      status: 'Выдан',
      trackId: 'RP166981607CN',
      weight: 0.152);
  test(
    'should be a subclass of TrackDetails',
    () async {
      // arrange
      // act
      // assert
      expect(tTrackDetailsModel, isA<TrackDetails>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = jsonDecode(fixture('track.json'));
        // act
        final result = TrackDetailsModel.fromJson(jsonMap);
        // assert
        expect(result, tTrackDetailsModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        // act
        final result = tTrackDetailsModel.toJson();
        // assert
        final expectedMap = {
          "trackid": "RP166981607CN",
          "label": "Новая посылка",
          "x_status_code": "Выдан",
          "error": null,
          "package_type": "Мелкий пакет СНГ/ДЗ",
          "category": "Заказное",
          "delivery_method": "Авиа",
          "weight": 0.152,
          "sender": {"country": "CN", "name": "1", "address": "1"},
          "receiver": {
            "name": "SHAKIROV   ROMAN",
            "address": "ALMATY    MAKATAEVA   127",
            "country": "KZ"
          },
          "last": {
            "date": "2019-02-03 23:14:21.454",
            "dep_name": "Постамат № 53 - ТРЦ Мегапарк",
            "address": "г.Алматы - ул.Макатаева 127",
            "postindex": "900533"
          }
        };
        expect(result, expectedMap);
      },
    );
  });
}
