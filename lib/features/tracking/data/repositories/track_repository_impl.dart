import 'package:dartz/dartz.dart';
import 'package:kazpost_tracker/core/error/failures.dart';
import 'package:kazpost_tracker/core/network/network_info.dart';
import 'package:kazpost_tracker/features/tracking/data/datasources/track_local_datasource.dart';
import 'package:kazpost_tracker/features/tracking/data/datasources/track_remote_datasource.dart';
import 'package:kazpost_tracker/features/tracking/data/models/track_model.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_details.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_history.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';
import 'package:meta/meta.dart';

class TrackRepositoryImpl implements TrackRepository {
  final TrackLocalDataSource localDataSource;
  final TrackRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TrackRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, TrackDetails>> getTrackDetails(String trackId) async {
    if (await networkInfo.isConnected) {
      final trackDetails = await remoteDataSource.getTrackDetails(trackId);
      localDataSource.saveTrackDetails(trackDetails);
      return Right(trackDetails);
    } else {
      final localTrackDetails = await localDataSource.getTrackDetails(trackId);
      return Right(localTrackDetails);
    }
  }

  @override
  Future<Either<Failure, TrackHistory>> getTrackHistory(String trackId) async {
    if (await networkInfo.isConnected) {
      final trackHistory = await remoteDataSource.getTrackHistory(trackId);
      localDataSource.saveTrackHistory(trackHistory);
      return Right(trackHistory);
    } else {
      final localTrackHistory = await localDataSource.getTrackHistory(trackId);
      return Right(localTrackHistory);
    }
  }

  @override
  Future<Either<Failure, List<Track>>> getTrackList() async {
    final trackList = await localDataSource.getTrackList();
    return Right(trackList);
  }

  @override
  Future<Either<Failure, String>> saveTrack(Track track) async {
    final trackModel = TrackModel(trackId: track.trackId, label: track.label);
    final reference = await localDataSource.saveTrack(trackModel);
    return Right(reference);
  }

  @override
  Future<Either<Failure, int>> deleteTrack(String trackId) async {
    final result = await localDataSource.deleteTrack(trackId);
    return Right(result);
  }
}
