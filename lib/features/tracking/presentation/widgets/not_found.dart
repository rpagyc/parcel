import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  final String trackId;

  NotFound(this.trackId);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Посылка $trackId не найдена в системе.'));
  }
}
