import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:kazpost_tracker/features/tracking/presentation/bloc/track_bloc.dart';

class EntryDialog extends StatefulWidget {
  final Track track;
  final Bloc bloc;

  EntryDialog({Key key, this.track, this.bloc}) : super(key: key);

  @override
  _EntryDialogState createState() => _EntryDialogState(bloc);
}

class _EntryDialogState extends State<EntryDialog> {
  final trackIdController = TextEditingController();
  final labelController = TextEditingController();
  final Bloc bloc;

  _EntryDialogState(this.bloc);

  @override
  void initState() {
    super.initState();
    trackIdController.text = widget.track?.trackId;
    labelController.text = widget.track?.label;
  }

  @override
  void dispose() {
    trackIdController.dispose();
    labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.track == null ? 'Новая Посылка' : 'Редактирование'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            autofocus: widget.track == null,
            enabled: widget.track == null,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: 'Номер трека',
              icon: Icon(Icons.mail_outline),
            ),
            controller: trackIdController,
          ),
          TextField(
            autofocus: widget.track != null,
            decoration: InputDecoration(
              labelText: 'Описание',
              icon: Icon(Icons.edit),
            ),
            controller: labelController,
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(widget.track == null ? 'Добавить' : 'Обновить'),
          onPressed: () {
            if (trackIdController.text.isNotEmpty) {
              bloc.add(SaveTrackEvent(
                  track: Track(
                trackId: trackIdController.text,
                label: labelController.text.isEmpty
                    ? 'Новая посылка'
                    : labelController.text,
              )));
            }
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
