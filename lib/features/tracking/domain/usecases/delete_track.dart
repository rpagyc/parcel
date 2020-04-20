import 'package:dartz/dartz.dart';
import 'package:kazpost_tracker/core/error/failures.dart';
import 'package:kazpost_tracker/core/usecases/usecase.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';

class DeleteTrack implements UseCase<int, String> {
  final TrackRepository repository;

  DeleteTrack(this.repository);

  @override
  Future<Either<Failure, int>> call(String trackId) async {
    return await repository.deleteTrack(trackId);
  }
}
