class Parcel {
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

  Parcel({
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

  Map<String, dynamic> toMap() => {
        'trackid': trackId,
        'label': label,
        'x_status_code': status,
        'error': error,
        'package_type': packageType,
        'category': category,
        'delivery_method': deliveryMethod,
        'weight': weight,
        'sender': sender?.toMap(),
        'receiver': receiver?.toMap(),
        'last': last?.toMap(),
      };

  static Parcel fromMap(Map<String, dynamic> map) {
    return map['error'] == null
        ? Parcel(
            trackId: map['trackid'],
            label: map['label'],
            status: map['x_status_code'],
            error: map['error'],
            packageType: map['package_type'],
            category: map['category'],
            deliveryMethod: map['delivery_method'],
            weight: map['weight'],
            sender: map['sender'] != null ? Sender.fromMap(map['sender']) : null,
            receiver: map['receiver'] != null ? Receiver.fromMap(map['receiver']) : null,
            last: map['last'] != null ? Last.fromMap(map['last']) : null,
          )
        : Parcel(
            trackId: map['trackid'],
            error: map['error'],
        );
  }
}

class Sender {
  final String country;
  final String name;
  final String address;

  Sender({
    this.country,
    this.name,
    this.address,
  });

  Map<String, dynamic> toMap() => {
        'country': country,
        'name': name,
        'address': address,
      };

  static Sender fromMap(Map<String, dynamic> map) => Sender(
        country: map['country'],
        name: map['name'],
        address: map['address'],
      );
}

class Receiver {
  final String name;
  final String address;
  final String country;

  Receiver({
    this.name,
    this.address,
    this.country,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'address': address,
        'country': country,
      };

  static Receiver fromMap(Map<String, dynamic> map) => Receiver(
        name: map['name'],
        address: map['address'],
        country: map['country'],
      );
}

class Last {
  final String date;
  final String depName;
  final String address;
  final String index;

  Last({
    this.date,
    this.depName,
    this.address,
    this.index,
  });

  Map<String, dynamic> toMap() => {
        'date': date,
        'dep_name': depName,
        'address': address,
        'index': index,
      };

  static Last fromMap(Map<String, dynamic> map) => Last(
        date: map['date'],
        depName: map['dep_name'],
        address: map['address'],
        index: map['index'],
      );
}
