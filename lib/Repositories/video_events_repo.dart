import 'package:notes_app1/repositories/video_repo.dart';
import 'package:video_player/video_player.dart';

class SqfLiteRepository implements VideoRepository {
  @override
  Future<void>? initializeVideo(VideoPlayerController videoPlayerController) {
    try {
      return videoPlayerController.initialize().onError(
          (error, stackTrace) => videoPlayerController.removeListener(() {}));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> playVideo(VideoPlayerController videoPlayerController) {
    return videoPlayerController.play().catchError((e) => print("e$e"));
  }

  @override
  Future<void> pauseVideo(VideoPlayerController videoPlayerController) {
    return videoPlayerController.pause().catchError((e) => print("e$e"));
  }

  @override
  void dispose(VideoPlayerController videoPlayerController) {
    videoPlayerController.dispose();
  }
}
