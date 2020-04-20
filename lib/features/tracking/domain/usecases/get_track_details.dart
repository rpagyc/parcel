import 'package:dartz/dartz.dart';
import 'package:kazpost_tracker/core/error/failures.dart';
import 'package:kazpost_tracker/core/usecases/usecase.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_details.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';

class GetTrackDetails implements UseCase<TrackDetails, String>{
  final TrackRepository repository;

  GetTrackDetails(this.repository);
  
  @override
  Future<Either<Failure, TrackDetails>> call(String trackId) async {
    return await repository.getTrackDetails(trackId);
  }
}