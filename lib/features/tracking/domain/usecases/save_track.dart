import 'package:dartz/dartz.dart';
import 'package:kazpost_tracker/core/error/failures.dart';
import 'package:kazpost_tracker/core/usecases/usecase.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';

class SaveTrack implements UseCase<String, Track>{
  final TrackRepository repository;

  SaveTrack(this.repository);

  @override
  Future<Either<Failure, String>> call(Track track) async {
    return await repository.saveTrack(track);
  }
}