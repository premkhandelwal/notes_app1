import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app1/repositories/video_repo.dart';
import 'package:video_player/video_player.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository? videoRepository;
  VideoBloc({this.videoRepository}) : super(VideoInitial());

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
   if (event is VideoLoading) {
      yield* _mapAddVideoToState(event);
    }
    else if(event is VideoPlay){
      yield* _mapPlayVideoToState(event);

    }
    else if(event is VideoPause){
      yield* _mapPauseVideoToState(event);

    }
  }

 Stream<VideoState>  _mapAddVideoToState(VideoLoading event)async* {
    videoRepository?.initializeVideo(event.controller);
  }
 Stream<VideoState>  _mapPlayVideoToState(VideoPlay event)async* {
    videoRepository?.playVideo(event.controller);
  }
 Stream<VideoState>  _mapPauseVideoToState(VideoPause event)async* {
    videoRepository?.playVideo(event.controller);
  }
}
