import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kazpost_tracker/data/kaspost_api.dart';
import 'package:kazpost_tracker/data/parcel.dart';
import 'package:kazpost_tracker/data/events.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final Parcel parcel;

  DetailScreen({
    Key key,
    @required this.parcel,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var _parcel = Parcel();
  var _events = Events();

  @override
  void initState() {
    super.initState();
    listenForParcel();
    listenForEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parcel.label),
      ),
      body: _parcel.status != null
          ? ListView(
              children: <Widget>[
                Information(
                  parcel: _parcel,
                ),
                Activity(
                  events: _events,
                )
              ],
            )
          : Center(
              child: Text(
                  'Посылка ${widget.parcel.trackId} не найдена в системе.')),
    );
  }

  void listenForParcel() async {
    var stream = await getParcel(widget.parcel.trackId);
    stream.listen((p) => setState(() => _parcel = p));
  }

  void listenForEvents() async {
    var stream = await getEvents(widget.parcel.trackId);
    stream.listen((e) => setState(() => _events = e));
  }
}

class Information extends StatelessWidget {
  final Parcel parcel;

  const Information({Key key, this.parcel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Информация',
            style: Theme.of(context).textTheme.title,
          ),
          Divider(),
          Text(
            'Номер почтового отправления',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(parcel.trackId),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Статус обработки отслеживания',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('${parcel.status}, ${parcel.last.date}'),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Получатель',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(parcel.receiver.name),
          Text(parcel.receiver.address),
          Text(parcel.receiver.country),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Отправитель',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(parcel.sender.name),
          Text(parcel.sender.address),
          Text(parcel.sender.country),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Информация о посылке',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Категория: ${parcel.category}'),
          Text('Тип посылки: ${parcel.packageType}'),
          Text('Способ доставки: ${parcel.deliveryMethod}'),
          Text('Вес: ${parcel.weight}'),
        ],
      ),
    );
  }
}

class Activity extends StatelessWidget {
  final Events events;

  const Activity({Key key, this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: events.events.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final event = events.events[index];
                var date = DateFormat('dd.MM.yyyy').parse(event.date);
                initializeDateFormatting('ru_RU', null);
                var fDate = DateFormat.yMMMMd("ru_RU").format(date);
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        fDate,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: event.activities.length,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final activity = event.activities[index];
                            return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Время: ${activity.time}'),
                                    Text('Индекс: ${activity.zip}'),
                                    Text(activity.city),
                                    Text(activity.name),
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
