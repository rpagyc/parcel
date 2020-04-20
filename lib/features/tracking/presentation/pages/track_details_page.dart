import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/presentation/bloc/track_bloc.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/details.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/history.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/loading_widget.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/not_found.dart';

class TrackDetailsPage extends StatefulWidget {
  final Track track;

  const TrackDetailsPage({Key key, this.track}) : super(key: key);

  @override
  _TrackDetailsPageState createState() => _TrackDetailsPageState();
}

class _TrackDetailsPageState extends State<TrackDetailsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TrackBloc>(context)
      ..add(GetTrackDetailsAndHistoryEvent(widget.track.trackId));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<TrackBloc>(context)..add(GetTrackListEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.track.label),
        ),
        body: BlocBuilder<TrackBloc, TrackState>(
          builder: (context, state) {
            if (state is Loading) {
              return LoadingWidget();
            } else if (state is DetailsAndHistoryLoaded) {
              if (state.trackDetails.error == null) {
                return ListView(
                  children: <Widget>[
                    Details(
                      details: state.trackDetails,
                    ),
                    History(
                      history: state.trackHistory,
                    )
                  ],
                );
              }
              return NotFound(widget.track.trackId);
            }
            return NotFound(widget.track.trackId);
          },
        ),
      ),
    );
  }
}
