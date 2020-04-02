class Events {
  String trackId;
  String timeStamp;
  List<Event> events;

  Events({
    this.trackId,
    this.timeStamp,
    this.events,
  });
  
  static Events fromMap(Map<String, dynamic> map) {
    var list = map['events'] as List;
    var events = list.map((m) => Event.fromMap(m)).toList();
    return Events(
      trackId: map['trackid'],
      timeStamp: map['timestamp'],
      events: events
    );
  }
}

class Event {
  String date;
  List<Activity> activities;

  Event({
    this.date,
    this.activities,
  });

  static Event fromMap(Map<String, dynamic> map) {
    var list = map['activity'] as List;
    List<Activity> activities = list.map((m) => Activity.fromMap(m)).toList();
    return Event(
      date: map['date'],
      activities: activities,
    );
  }
}

class Activity {
  String time;
  String zip;
  String city;
  String name;
  String depId;
  List<String> status;
  String depCode;
  String nondlvReason;
  String returnReason;
  String forwardReason;

  Activity({
    this.time,
    this.zip,
    this.city,
    this.name,
    this.depId,
    this.status,
    this.depCode,
    this.nondlvReason,
    this.returnReason,
    this.forwardReason,
  });

  static Activity fromMap(Map<String, dynamic> map) {
    return Activity(
      time: map['time'],
      zip: map['zip'],
      city: map['city'],
      name: map['name'],
      depId: map['x_dep_id'],
      status: List<String>.from(map['status']),
      depCode: map['dep_code'],
      nondlvReason: map['nondlv_reason'],
      returnReason: map['return_reason'],
      forwardReason: map['forward_reason'],
    );
  }
}
