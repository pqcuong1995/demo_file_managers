import 'dart:io';

import 'package:demo_file_manager/BLOC/base/StatefulBase.dart';
import 'package:demo_file_manager/BLOC/player_audio/play_audio_bloc.dart';
import 'package:demo_file_manager/Utils/Util.dart';
import 'package:demo_file_manager/model/Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

class PlayAudio extends StatefulWidget {
  final Item? item;
  PlayAudio({this.item});
  @override
  State<StatefulWidget> createState() {
    return PlayAudioState();
  }
}

class PlayAudioState extends StatefulBaseState<PlayAudio> {
  late VideoPlayerController _controller;
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void dispose() {
    audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = VideoPlayerController.file(File(widget.item!.path!))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play'),
      ),
      body: BlocProvider(
        create: (context) =>
            PlayAudioBloc(context: context, audioPlayer: audioPlayer),
        child: BlocBuilder<PlayAudioBloc, PlayAudioInitial>(
          builder: (context, state) {
            if (GlobalUtil.VIDEOType.contains(widget.item!.type)) {
              return _buildVideoWidget();
            } else {
              return Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.skip_previous),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<PlayAudioBloc>(context).add(PlayEvent(
                              item: widget.item, isPlay: state.isPlayState));
                        },
                        icon: state.isPlayState!
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.skip_next),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<PlayAudioBloc>(context)
                              .add(StopEvent());
                        },
                        icon: Icon(Icons.stop),
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildVideoWidget() {
    return Stack(
      children: <Widget>[
        Positioned(child: Align(
          alignment: Alignment.center,
          child: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : Container(),
          ),
        )),
        Positioned(child: Align(
          alignment: Alignment.center,
            child: Container(
              color: Colors.white,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                icon: _controller.value.isPlaying
                    ? Icon(Icons.pause)
                    : Icon(Icons.play_arrow),
                iconSize: 30,
              ),
            ),
          ),
        )
      ],
    );

  }
}
