import 'package:dartz/dartz.dart';
import 'package:kazpost_tracker/core/error/failures.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_details.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_history.dart';

abstract class TrackRepository {
  Future<Either<Failure, List<Track>>> getTrackList();
  Future<Either<Failure, String>> saveTrack(Track track);
  Future<Either<Failure, TrackDetails>> getTrackDetails(String trackId);
  Future<Either<Failure, TrackHistory>> getTrackHistory(String trackId);
  Future<Either<Failure, int>> deleteTrack(String trackId);
}