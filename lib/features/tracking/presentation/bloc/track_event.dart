part of 'track_bloc.dart';

abstract class TrackEvent extends Equatable {
  const TrackEvent() : super();
}

class GetTrackListEvent extends TrackEvent {
  @override
  List<Object> get props => [];
}

class SaveTrackEvent extends TrackEvent {
  final Track track;

  SaveTrackEvent({this.track});

  @override
  List<Object> get props => [track];
}

class GetTrackDetailsAndHistoryEvent extends TrackEvent {
  final String trackId;

  GetTrackDetailsAndHistoryEvent(this.trackId);

  @override
  List<Object> get props => [trackId];
}

class DeleteTrackEvent extends TrackEvent {
  final String trackId;

  DeleteTrackEvent(this.trackId);
  @override
  List<Object> get props => [];
}
