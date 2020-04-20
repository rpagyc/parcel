import 'package:kazpost_tracker/features/tracking/domain/entities/track_details.dart';

class TrackDetailsModel extends TrackDetails {
  final SenderModel sender;
  final ReceiverModel receiver;
  final LastModel last;

  TrackDetailsModel({
    String trackId,
    String label,
    String status,
    String error,
    String packageType,
    String category,
    String deliveryMethod,
    double weight,
    this.sender,
    this.receiver,
    this.last,
  }) : super(
          trackId: trackId,
          label: label,
          status: status,
          error: error,
          packageType: packageType,
          category: category,
          deliveryMethod: deliveryMethod,
          weight: weight,
          sender: sender,
          receiver: receiver,
          last: last,
        );

  factory TrackDetailsModel.fromJson(Map<String, dynamic> json) {
    return json['error'] == null
        ? TrackDetailsModel(
            trackId: json['trackid'],
            label: json['label'] ?? 'Новая посылка',
            status: json['x_status_code'],
            error: json['error'],
            packageType: json['package_type'],
            category: json['category'],
            deliveryMethod: json['delivery_method'],
            weight: json['weight'],
            sender: json['sender'] != null
                ? SenderModel.fromJson(json['sender'])
                : null,
            receiver: json['receiver'] != null
                ? ReceiverModel.fromJson(json['receiver'])
                : null,
            last:
                json['last'] != null ? LastModel.fromJson(json['last']) : null,
          )
        : TrackDetailsModel(
            trackId: json['trackid'],
            error: json['error'],
          );
  }

  Map<String, dynamic> toJson() => {
        'trackid': trackId,
        'label': label,
        'x_status_code': status,
        'error': error,
        'package_type': packageType,
        'category': category,
        'delivery_method': deliveryMethod,
        'weight': weight,
        'sender': sender?.toJson(),
        'receiver': receiver?.toJson(),
        'last': last?.toJson(),
      };
}

class SenderModel extends Sender {
  SenderModel({
    String country,
    String name,
    String address,
  }) : super(
          country: country,
          name: name,
          address: address,
        );

  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return SenderModel(
      country: json['country'],
      name: json['name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        'country': country,
        'name': name,
        'address': address,
      };
}

class ReceiverModel extends Receiver {
  ReceiverModel({
    name,
    address,
    country,
  }) : super(
          name: name,
          address: address,
          country: country,
        );
  factory ReceiverModel.fromJson(Map<String, dynamic> json) {
    return ReceiverModel(
      name: json['name'],
      address: json['address'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'country': country,
      };
}

class LastModel extends Last {
  LastModel({
    String date,
    String depName,
    String address,
    String index,
  }) : super(
          date: date,
          depName: depName,
          address: address,
          index: index,
        );
  factory LastModel.fromJson(Map<String, dynamic> json) {
    return LastModel(
      date: json['date'],
      depName: json['dep_name'],
      address: json['address'],
      index: json['postindex'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'dep_name': depName,
        'address': address,
        'postindex': index,
      };
}
