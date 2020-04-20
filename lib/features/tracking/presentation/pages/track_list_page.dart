import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazpost_tracker/features/tracking/presentation/bloc/track_bloc.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/add_new_track.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/empty_list.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/loading_widget.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/track_list.dart';

import '../../../../injection_container.dart';

class TrackListPage extends StatelessWidget {
  final _bloc = sl<TrackBloc>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _bloc.add(GetTrackListEvent()));

    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Мои посылки'),
        ),
        body: BlocBuilder<TrackBloc, TrackState>(
          builder: (context, state) {
            if (state is Loading) {
              return LoadingWidget();
            }
            if (state is TrackListLoaded) {
              if (state.trackList.isEmpty) return EmptyList();
              final trackList = state.trackList;
              return TrackList(trackList: trackList, bloc: _bloc);
            }
            return EmptyList();
          },
        ),
        floatingActionButton: AddNewTrack(bloc: _bloc),
      ),
    );
  }
}
