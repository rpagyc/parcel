import 'package:kazpost_tracker/features/tracking/data/app_database.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_details_model.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_history_model.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_model.dart';
import 'package:sembast/sembast.dart';
import 'package:meta/meta.dart';

abstract class TrackLocalDataSource {
  Future<List<TrackModel>> getTrackList();
  Future<String> saveTrack(TrackModel track);
  Future<int> deleteTrack(String trackId);
  Future<String> saveTrackDetails(TrackDetailsModel trackDetails);
  Future<String> saveTrackHistory(TrackHistoryModel trackHistory);
  Future<TrackDetailsModel> getTrackDetails(String trackId);
  Future<TrackHistoryModel> getTrackHistory(String trackId);
}

class TrackLocalDataSourceImpl implements TrackLocalDataSource {
  final AppDatabase database;

  final StoreRef<String, Map<String, dynamic>> tracks;
  final StoreRef<String, Map<String, dynamic>> details;
  final StoreRef<String, Map<String, dynamic>> history;

  Future<Database> get _db async => await database.instance;

  TrackLocalDataSourceImpl({
    @required this.database,
    @required this.tracks,
    @required this.details,
    @required this.history,
  });

  @override
  Future<List<TrackModel>> getTrackList() async {
    final recordSnapshots = await tracks.find(await _db);
    final result = recordSnapshots
        .map((snapshot) => TrackModel.fromJson(snapshot.value))
        .toList();
    return result;
  }

  @override
  Future<String> saveTrack(TrackModel track) async {
    return tracks.record(track.trackId).put(await _db, track.toJson());
  }

  @override
  Future<int> deleteTrack(String trackId) async {
    return tracks.delete(await _db,
        finder: Finder(filter: Filter.byKey(trackId)));
  }

  @override
  Future<TrackDetailsModel> getTrackDetails(String trackId) async {
    final result = await details.record(trackId).get(await _db);
    return TrackDetailsModel.fromJson(result);
  }

  @override
  Future<TrackHistoryModel> getTrackHistory(String trackId) async {
    final result = await history.record(trackId).get(await _db);
    return TrackHistoryModel.fromJson(result);
  }

  @override
  Future<String> saveTrackDetails(TrackDetailsModel trackDetails) async {
    return details.record(trackDetails.trackId).put(await _db, trackDetails.toJson());
  }

  @override
  Future<String> saveTrackHistory(TrackHistoryModel trackHistory) async {
    return history.record(trackHistory.trackId).put(await _db, trackHistory.toJson());
  }
}
