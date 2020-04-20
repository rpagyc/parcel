import 'package:kazpost_tracker/features/tracking/domain/entities/track.dart';
import 'package:meta/meta.dart';

class TrackModel extends Track {
  TrackModel({
    @required String trackId,
    @required String label,
  }) : super(trackId: trackId, label: label);

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      label: json['label'] ?? 'Новая посылка',
      trackId: json['trackid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackid': trackId,
      'label': label,
    };
  }
}
