import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/presentation/bloc/track_bloc.dart';
import 'package:kazpost_tracker/features/tracking/presentation/pages/track_details_page.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/entry_dialog.dart';

class TrackList extends StatelessWidget {
  const TrackList({
    Key key,
    @required this.trackList,
    @required TrackBloc bloc,
  })  : _bloc = bloc,
        super(key: key);

  final List<Track> trackList;
  final TrackBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trackList.length,
      itemBuilder: (context, index) {
        final track = trackList[index];
        return Card(
                  child: Dismissible(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('images/parcel_icon.png'),
              ),
              title: Text(track.label),
              subtitle: Text(track.trackId),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                tooltip: 'Редактировать',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => EntryDialog(
                      bloc: _bloc,
                      track: track,
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: _bloc,
                        child: TrackDetailsPage(
                          track: track,
                        ),
                      ),
                    ));
              },
            ),
            key: Key(track.trackId),
            onDismissed: (direction) {
              _bloc.add(DeleteTrackEvent(track.trackId));
            },
            background: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  Text(
                    'Удалить',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
