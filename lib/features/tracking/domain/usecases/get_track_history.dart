import 'package:dartz/dartz.dart';
import 'package:kazpost_tracker/core/error/failures.dart';
import 'package:kazpost_tracker/core/usecases/usecase.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_history.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';

class GetTrackHistory implements UseCase<TrackHistory, String>{
  final TrackRepository repository;

  GetTrackHistory(this.repository);

  @override
  Future<Either<Failure, TrackHistory>> call(String trackId) async {
    return await repository.getTrackHistory(trackId);
  }
}