part of 'video_bloc.dart';

@immutable
abstract class VideoEvent {}


class VideoPlay extends VideoEvent {
   final VideoPlayerController controller;

  VideoPlay({required this.controller});
}

class VideoPause extends VideoEvent {
     final VideoPlayerController controller;

  VideoPause({required this.controller});
}