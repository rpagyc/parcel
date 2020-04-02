import 'package:flutter/material.dart';
import 'package:kazpost_tracker/bloc/parcel_bloc.dart';
import 'package:kazpost_tracker/data/parcel.dart';

class EntryDialog extends StatefulWidget {
  final String trackId;
  final String label;
  
  EntryDialog({Key key, this.trackId, this.label}) : super(key: key);
  
  @override
  _EntryDialogState createState() => _EntryDialogState();
}

class _EntryDialogState extends State<EntryDialog> {
  final trackIdController = TextEditingController();
  final labelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    trackIdController.text = widget.trackId;
    labelController.text = widget.label;
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
      title: Text(widget.trackId == null ? 'Новая Посылка' : 'Редактирование'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            autofocus: widget.trackId == null,
            enabled: widget.trackId == null,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: 'Номер трека',
              icon: Icon(Icons.mail_outline),
            ),
            controller: trackIdController,
          ),
          TextField(
            autofocus: widget.trackId != null,
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
          child: Text(widget.trackId == null ? 'Добавить' : 'Обновить'),
          onPressed: () {
            if (trackIdController.text.isNotEmpty) {
              ParcelBloc().putParcel(
                Parcel(
                  trackId: trackIdController.text,
                  label: labelController.text.isEmpty ? 'Новая посылка' : labelController.text,
                ),
              );
            }
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
