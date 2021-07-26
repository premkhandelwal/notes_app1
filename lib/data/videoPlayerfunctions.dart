import 'package:video_player/video_player.dart';

class VideoPlayerFunctions {

  
  Future<void>? initializeVideo(VideoPlayerController videoPlayerController) {
    try {
      return videoPlayerController.initialize().onError(
          (error, stackTrace) => videoPlayerController.removeListener(() {}));
    } catch (e) {
      return null;
    }
  }


  Future<void> playVideo(VideoPlayerController videoPlayerController) {
    return videoPlayerController.play();
  }

  Future<void> pauseVideo(VideoPlayerController videoPlayerController) {
    return videoPlayerController.pause();
  }


  void dispose(VideoPlayerController videoPlayerController) {
    videoPlayerController.dispose();
  }
}
