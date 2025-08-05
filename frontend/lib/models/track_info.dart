// // lib/models/track_info.dart
// class TrackInfo {
//   final String imagePath;
//   final String name;
//   final String artist;

//   TrackInfo({
//     required this.imagePath,
//     required this.name,
//     required this.artist,
//   });
// }

class TrackInfo {
  final String imagePath; // Local image
  final String name;
  final String artist;
  final String? cover; // Online cover image
  final String? appleMusicUrl; // Apple Music URL

  TrackInfo({
    required this.imagePath,
    required this.name,
    required this.artist,
    this.cover,
    this.appleMusicUrl,
  });
}
