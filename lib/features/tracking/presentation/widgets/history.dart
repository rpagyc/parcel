import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_history.dart';
import 'package:intl/date_symbol_data_local.dart';

class History extends StatelessWidget {
  final TrackHistory history;

  const History({Key key, this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: history.events.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final event = history.events[index];
                var date = DateFormat('dd.MM.yyyy').parse(event.date);
                initializeDateFormatting('ru_RU', null);
                var fDate = DateFormat.yMMMMd("ru_RU").format(date);
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 25,
                              alignment: Alignment.center,
                              color: Colors.blue,
                              child: Text(
                                fDate,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: event.activities.length,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final activity = event.activities[index];
                            return Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Divider(),
                                    Text('Время: ${activity.time}'),
                                    Text('Индекс: ${activity.zip}'),
                                    Text(activity.city),
                                    Text(activity.name),
                                    Divider(),
                                  ],
                                ));
                          })
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
