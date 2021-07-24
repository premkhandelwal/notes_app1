import 'package:video_player/video_player.dart';

abstract class VideoRepository {
  Future<void>? initializeVideo(VideoPlayerController videoPlayerController);
  Future<void> playVideo(VideoPlayerController videoPlayerController);
  Future<void> pauseVideo(VideoPlayerController videoPlayerController);
  void dispose(VideoPlayerController videoPlayerController);
}
