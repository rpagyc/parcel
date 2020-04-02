import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kazpost_tracker/data/parcel.dart';
import 'package:kazpost_tracker/data/events.dart';

String url = 'http://track.kazpost.kz/api/v2';

Future<Stream<Parcel>> getParcel(String trackId) async {
  var parcelUrl = '$url/$trackId';

  var client = http.Client();

  var streamedRes = await client.send(http.Request('get', Uri.parse(parcelUrl)));

  return streamedRes.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((jsonParcel) => Parcel.fromMap(jsonParcel));
}

Future<Stream<Events>> getEvents(String trackId) async {
  var eventsUrl = '$url/$trackId/events';
  
  var client = http.Client();

  var streamedRes = await client.send(http.Request('get', Uri.parse(eventsUrl)));

  return streamedRes.stream
      .transform(utf8.decoder)  
      .transform(json.decoder)
      .map((json) => Events.fromMap(json));
}