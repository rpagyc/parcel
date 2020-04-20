import 'package:dartz/dartz.dart';
import 'package:kazpost_tracker/core/error/failures.dart';
import 'package:kazpost_tracker/core/usecases/usecase.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/domain/repositories/track_repository.dart';

class GetTrackList implements UseCase<List<Track>, NoParams> {
  final TrackRepository repository;

  GetTrackList(this.repository);
  
  @override
  Future<Either<Failure, List<Track>>> call(NoParams params) async {
    return await repository.getTrackList();
  }
  
}