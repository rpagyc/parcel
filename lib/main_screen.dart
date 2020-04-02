import 'package:kazpost_tracker/bloc/parcel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kazpost_tracker/data/parcel.dart';
import 'package:kazpost_tracker/detail_screen.dart';
import 'package:kazpost_tracker/entry_dialog.dart';

class MainScreen extends StatelessWidget {
  final String title;

  MainScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder<List<Parcel>>(
        initialData: ParcelBloc().stream$.value,
        stream: ParcelBloc().stream$,
        builder: (context, snapshot) {
          var parcels = snapshot.data;
          if (parcels.isEmpty) {
            return Center(
              child: Text("Нет отслеживаемых посылок"),
            );
          } else {
            return ListView.builder(
              itemCount: parcels.length,
              itemBuilder: (context, index) {
                final parcel = parcels[index];
                return Dismissible(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('images/parcel_icon.png'),
                    ),
                    title: Text(parcel.label),
                    subtitle: Text(parcel.trackId),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      tooltip: 'Редактировать',
                      onPressed: () {
                        _showEntryDialog(context, parcel);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  parcel: parcel,
                                ),
                          ));
                    },
                  ),
                  key: Key(parcel.trackId),
                  onDismissed: (direction) {
                    ParcelBloc().deleteParcel(parcel.trackId);
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
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.mail_outline),
        onPressed: () => _showEntryDialog(context, null),
        tooltip: 'Добавить посылку',
      ),
    );
  }

  _showEntryDialog(BuildContext context, Parcel parcel) {
    showDialog(
        context: context,
        builder: (context) {
          return EntryDialog(trackId: parcel?.trackId, label: parcel?.label);
        });
  }
}
