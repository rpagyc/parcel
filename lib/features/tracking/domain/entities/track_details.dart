import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TrackDetails extends Equatable {
  final String trackId;
  final String label;
  final String status;
  final String error;
  final String packageType;
  final String category;
  final String deliveryMethod;
  final double weight;
  final Sender sender;
  final Receiver receiver;
  final Last last;

  TrackDetails({
    this.trackId,
    this.label,
    this.status,
    this.error,
    this.packageType,
    this.category,
    this.deliveryMethod,
    this.weight,
    this.sender,
    this.receiver,
    this.last,
  });

  @override
  List<Object> get props => [
        trackId,
        label,
        status,
        error,
        packageType,
        category,
        deliveryMethod,
        weight,
        sender,
        receiver,
        last
      ];
}

class Sender extends Equatable {
  final String country;
  final String name;
  final String address;

  Sender({
    @required this.country,
    @required this.name,
    @required this.address,
  });

  @override
  List<Object> get props => [country, name, address];
}

class Receiver extends Equatable {
  final String name;
  final String address;
  final String country;

  Receiver({
    @required this.name,
    @required this.address,
    @required this.country,
  });

  @override
  List<Object> get props => [name, address, country];
}

class Last extends Equatable {
  final String date;
  final String depName;
  final String address;
  final String index;

  Last({
    @required this.date,
    @required this.depName,
    @required this.address,
    @required this.index,
  });

  @override
  List<Object> get props => [date, depName, address, index];
}
