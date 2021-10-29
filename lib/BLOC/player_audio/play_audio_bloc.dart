import 'package:bloc/bloc.dart';
import 'package:demo_file_manager/model/Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'play_audio_event.dart';
part 'play_audio_state.dart';

class PlayAudioBloc extends Bloc<PlayAudioEvent, PlayAudioInitial> {
  final AudioPlayer? audioPlayer;
  final BuildContext? context;
  bool? isPlay = false;
  PlayAudioBloc({this.context, this.audioPlayer})
      : super(PlayAudioInitial(isPlayState: false)) {
    on<PlayAudioEvent>((event, emit) async {
      if (event is PlayEvent) {
        isPlay = !event.isPlay!;
        if (isPlay!) {
          _playMusic(event.item!.path!);
        }else{
          _pauseMusic();
        }
        emit.call(state.play(isPlay!));
      }
      if (event is DisposeEvent) {
        _disposeMusic();
      }
      if(event is StopEvent){
        isPlay = !isPlay!;
        _stopMusic();
        emit.call(state.play(isPlay!));
      }
    });
  }

  Future _playMusic(String path) async {
    await audioPlayer!.stop();
    await audioPlayer!.setFilePath(path);
    await audioPlayer!.play();
  }

  Future _pauseMusic() async {
    await audioPlayer!.pause();
  }

  Future _stopMusic() async {
    await audioPlayer!.stop();
  }

  Future _disposeMusic() async {
    await audioPlayer!.dispose();
  }
}
