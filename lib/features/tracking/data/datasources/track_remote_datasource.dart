import 'dart:convert';

import 'package:kazpost_tracker/features/tracking/data/models/track_details_model.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_history_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class TrackRemoteDataSource {
  Future<TrackDetailsModel> getTrackDetails(String trackId);
  Future<TrackHistoryModel> getTrackHistory(String trackId);
}

class TrackRemoteDataSourceImpl implements TrackRemoteDataSource {
  final http.Client client;
  final apiUrl = 'http://track.kazpost.kz/api/v2';

  TrackRemoteDataSourceImpl({@required this.client});

  @override
  Future<TrackDetailsModel> getTrackDetails(String trackId) async {
    final response = await client.get(
      '$apiUrl/$trackId',
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
    return TrackDetailsModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<TrackHistoryModel> getTrackHistory(String trackId) async {
    final response = await client.get(
      '$apiUrl/$trackId/events',
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
    return TrackHistoryModel.fromJson(jsonDecode(response.body));
  }
}
