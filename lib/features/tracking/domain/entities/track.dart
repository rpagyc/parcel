import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Track extends Equatable {
  final String trackId;
  final String label;

  Track({
    @required this.trackId,
    @required this.label,
  });

  @override
  List<Object> get props => [trackId, label];
}
