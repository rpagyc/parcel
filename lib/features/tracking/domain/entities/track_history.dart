import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TrackHistory extends Equatable {
  final String trackId;
  final String timeStamp;
  final List<Event> events;

  TrackHistory({
    this.trackId,
    this.timeStamp,
    this.events,
  });

  @override
  List<Object> get props => [trackId, timeStamp, events];
}

class Event extends Equatable {
  final String date;
  final List<Activity> activities;

  Event({
    @required this.date,
    @required this.activities,
  });

  @override
  List<Object> get props => [date, activities];
}

class Activity extends Equatable {
  final String time;
  final String zip;
  final String city;
  final String name;
  final String depId;
  final List<String> status;
  final String depCode;
  final String nondlvReason;
  final String returnReason;
  final String forwardReason;

  Activity({
    @required this.time,
    @required this.zip,
    @required this.city,
    @required this.name,
    @required this.depId,
    @required this.status,
    @required this.depCode,
    @required this.nondlvReason,
    @required this.returnReason,
    @required this.forwardReason,
  });

  @override
  List<Object> get props => [
        time,
        zip,
        city,
        name,
        depId,
        status,
        depCode,
        nondlvReason,
        returnReason,
        forwardReason
      ];
}
