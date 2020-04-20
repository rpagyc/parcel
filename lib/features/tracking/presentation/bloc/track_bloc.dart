import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazpost_tracker/core/usecases/usecase.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_details.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_history.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/delete_track.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_details.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_history.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_list.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/save_track.dart';
import 'package:meta/meta.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final GetTrackList getTrackList;
  final SaveTrack saveTrack;
  final GetTrackHistory getTrackHistory;
  final GetTrackDetails getTrackDetails;
  final DeleteTrack deleteTrack;

  TrackBloc({
    @required this.getTrackList,
    @required this.saveTrack,
    @required this.getTrackHistory,
    @required this.getTrackDetails,
    @required this.deleteTrack,
  });

  @override
  TrackState get initialState => Empty();

  @override
  Stream<TrackState> mapEventToState(
    TrackEvent event,
  ) async* {
    if (event is GetTrackListEvent) {
      yield* _loadTrackList();
    } else if (event is SaveTrackEvent) {
      await saveTrack(event.track);
      yield* _loadTrackList();
    } else if (event is GetTrackDetailsAndHistoryEvent) {
      yield Loading();
      final detailsCall = await getTrackDetails(event.trackId);
      final historyCall = await getTrackHistory(event.trackId);
      var details = detailsCall.fold((f) => null, (details) => details);
      var history = historyCall.fold((f) => null, (history) => history);
      yield DetailsAndHistoryLoaded(
          trackDetails: details, trackHistory: history);
    } else if (event is DeleteTrackEvent) {
      await deleteTrack(event.trackId);
      yield* _loadTrackList();
    }
  }

  Stream<TrackState> _loadTrackList() async* {
    yield Loading();
    final result = await getTrackList(NoParams());
    yield result.fold(
      (failure) => Error(message: 'Cache failure'),
      (trackList) => TrackListLoaded(trackList: trackList),
    );
  }
}
