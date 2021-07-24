import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/businessLogic/bloc/video_bloc.dart';
import 'package:notes_app1/data/notes.dart';
import 'package:video_player/video_player.dart';

class DetailNotesScreen extends StatefulWidget {
  const DetailNotesScreen({Key? key, required this.note}) : super(key: key);
  final Notes? note;
  @override
  _DetailNotesScreenState createState() => _DetailNotesScreenState();
}

bool nointernet = false;

class _DetailNotesScreenState extends State<DetailNotesScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    nointernet = false;
    _controller = VideoPlayerController.network(
      widget.note!.videoLink!,
    );

    super.initState();
  }

  @override
  void dispose() {
    context.read<VideoBloc>().videoRepository!.dispose(_controller);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
        if (state is VideoInitial) {
          context.read<VideoBloc>().add(VideoLoading(controller: _controller));
        } else if (state is VideoLoading) {
          return CircularProgressIndicator();
        }
        return Container(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),

                ControlsOverlay(controller: _controller),
                // VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ControlsOverlay extends StatefulWidget {
  const ControlsOverlay({Key? key, required this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  __ControlsOverlayState createState() => __ControlsOverlayState();
}

class __ControlsOverlayState extends State<ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        !widget.controller.value.isPlaying
            ? Container(
                color: Colors.black26,
                child: Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 100.0,
                  ),
                ),
              )
            : SizedBox.shrink(),
        GestureDetector(
          onTap: () {
            try {
              setState(() {
                widget.controller.value.isPlaying
                    ? widget.controller.pause()
                    : widget.controller.play();
              });
            } catch (e) {
             
              setState(() {
                nointernet = true;
              });
            }
          },
        ),
      ],
    );
  }
}
