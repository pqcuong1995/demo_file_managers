part of 'play_audio_bloc.dart';

@immutable
abstract class PlayAudioState {}

class PlayAudioInitial extends PlayAudioState {
  final bool? isPlayState ;
  PlayAudioInitial({this.isPlayState});
  @override
  List<Object?> get props =>[];


  PlayAudioInitial play(bool play){
    return PlayAudioInitial(isPlayState: play);
  }

  PlayAudioInitial dispose(){
    return PlayAudioInitial();
  }

  PlayAudioInitial stopState(){
    return PlayAudioInitial();
  }
}
