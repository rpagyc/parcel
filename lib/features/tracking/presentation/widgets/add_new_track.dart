import 'package:flutter/material.dart';
import 'package:kazpost_tracker/features/tracking/presentation/bloc/track_bloc.dart';
import 'package:kazpost_tracker/features/tracking/presentation/widgets/entry_dialog.dart';

class AddNewTrack extends StatelessWidget {
  const AddNewTrack({
    Key key,
    @required TrackBloc bloc,
  }) : _bloc = bloc, super(key: key);

  final TrackBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      child: Icon(Icons.mail_outline),
      onPressed: () => showDialog(
        context: context,
        builder: (_) => EntryDialog(bloc: _bloc),
      ),
      tooltip: 'Добавить посылку',
    );
  }
}
