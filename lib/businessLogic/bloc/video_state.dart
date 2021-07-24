part of 'video_bloc.dart';

@immutable
abstract class VideoState {}

class VideoInitial extends VideoState {}


class VideoLoading extends VideoEvent {
  final VideoPlayerController controller;

  VideoLoading({required this.controller});
}

