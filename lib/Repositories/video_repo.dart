import 'package:notes_app1/data/videoPlayerfunctions.dart';
import 'package:video_player/video_player.dart';

class VideoRepository {
  final VideoPlayerFunctions? videoPlayerFunctions;
  VideoRepository({
   required this.videoPlayerFunctions,
  });

  Future<void>? initializeVideo(VideoPlayerController videoPlayerController) {
    videoPlayerFunctions?.initializeVideo(videoPlayerController);
  }

  Future<void>? playVideo(VideoPlayerController videoPlayerController){
    videoPlayerFunctions?.playVideo(videoPlayerController);
  }

  Future<void>? pauseVideo(VideoPlayerController videoPlayerController){
    videoPlayerFunctions?.pauseVideo(videoPlayerController);

  }
  void dispose(VideoPlayerController videoPlayerController){
    videoPlayerFunctions?.dispose(videoPlayerController);

  }
}
