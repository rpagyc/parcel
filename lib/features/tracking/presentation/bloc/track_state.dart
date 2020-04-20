part of 'track_bloc.dart';

abstract class TrackState extends Equatable {
  const TrackState();
}

class Empty extends TrackState {
  @override
  List<Object> get props => [];
}

class Loading extends TrackState {
  @override
  List<Object> get props => [];
}

class TrackListLoaded extends TrackState {
  final List<Track> trackList;

  TrackListLoaded({@required this.trackList});
  @override
  List<Object> get props => [trackList];
}

class DetailsAndHistoryLoaded extends TrackState {
  final TrackDetails trackDetails;
  final TrackHistory trackHistory;

  DetailsAndHistoryLoaded({
    @required this.trackDetails,
    @required this.trackHistory,
  });

  @override
  List<Object> get props => [trackDetails, trackHistory];
}

class Error extends TrackState {
  final String message;

  Error({this.message});

  @override
  List<Object> get props => [message];
}
