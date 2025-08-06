import 'package:frontend/models/track_info.dart';

class Moodboard {
  final String title;
  final String description;
  final List<String> tags;
  final List<String> imagePaths;
  final List<TrackInfo> tracksInfo;

  Moodboard({
    required this.title,
    required this.description,
    required this.tags,
    required this.imagePaths,
    required this.tracksInfo,
  });
}
