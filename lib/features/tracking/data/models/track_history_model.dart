import 'package:kazpost_tracker/features/tracking/domain/entities/track_history.dart';

class TrackHistoryModel extends TrackHistory {
  final List<EventModel> events;
  final String error;

  TrackHistoryModel({String trackId, String timeStamp, this.events, this.error})
      : super(trackId: trackId, timeStamp: timeStamp, events: events);

  factory TrackHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['error'] == null) {
      var list = json['events'] as List;
      var events = list.map((m) => EventModel.fromJson(m)).toList();
      return TrackHistoryModel(
          trackId: json['trackid'],
          timeStamp: json['timestamp'],
          events: events);
    } else {
      return TrackHistoryModel(
        trackId: json['trackid'],
        error: json['error'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    if (this.error == null)
      return {
        'trackid': trackId,
        'timestamp': timeStamp,
        'events': events.map((e) => e.toJson())
      };
    else
      return {'trackid': trackId, 'error': error};
  }
}

class EventModel extends Event {
  final List<ActivityModel> activities;

  EventModel({
    String date,
    this.activities,
  }) : super(date: date, activities: activities);

  factory EventModel.fromJson(Map<String, dynamic> json) {
    var list = json['activity'] as List;
    var activities = list.map((m) => ActivityModel.fromJson(m)).toList();
    return EventModel(
      date: json['date'],
      activities: activities,
    );
  }

  Map<String, dynamic> toJson() =>
      {'date': date, 'activity': activities.map((a) => a.toJson())};
}

class ActivityModel extends Activity {
  ActivityModel({
    String time,
    String zip,
    String city,
    String name,
    String depId,
    List<String> status,
    String depCode,
    String nondlvReason,
    String returnReason,
    String forwardReason,
  }) : super(
          time: time,
          zip: zip,
          city: city,
          name: name,
          depId: depId,
          status: status,
          depCode: depCode,
          nondlvReason: nondlvReason,
          returnReason: returnReason,
          forwardReason: forwardReason,
        );

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      time: json['time'],
      zip: json['zip'],
      city: json['city'],
      name: json['name'],
      depId: json['x_dep_id'],
      status: List<String>.from(json['status']),
      depCode: json['dep_code'],
      nondlvReason: json['nondlv_reason'],
      returnReason: json['return_reason'],
      forwardReason: json['forward_reason'],
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'zip': zip,
        'city': city,
        'name': name,
        'x_dep_id': depId,
        'status': status,
        'dep_code': depCode,
        'nondlv_reason': nondlvReason,
        'return_reason': returnReason,
        'forward_reason': forwardReason
      };
}
