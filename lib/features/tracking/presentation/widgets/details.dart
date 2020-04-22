import 'package:flutter/material.dart';
import 'package:kazpost_tracker/features/tracking/domain/entities/track_details.dart';

class Details extends StatelessWidget {
  final TrackDetails details;

  const Details({Key key, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
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
            Text(details.trackId),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Статус обработки отслеживания',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${details.status}, ${details.last.date}'),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Получатель',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(details.receiver.name),
            Text(details.receiver.address),
            Text(details.receiver.country),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Отправитель',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(details.sender.name),
            Text(details.sender.address),
            Text(details.sender.country),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Информация о посылке',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Категория: ${details.category}'),
            Text('Тип посылки: ${details.packageType}'),
            Text('Способ доставки: ${details.deliveryMethod}'),
            Text('Вес: ${details.weight}'),
          ],
        ),
      ),
    );
  }
}
