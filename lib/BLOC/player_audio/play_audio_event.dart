part of 'play_audio_bloc.dart';

@immutable
abstract class PlayAudioEvent {
  const PlayAudioEvent();
  List<Object?> get props => [];
}

class PlayEvent extends PlayAudioEvent {
  Item? item;
  bool? isPlay = false;
  PlayEvent({this.item, this.isPlay});
  @override
  List<Object?> get props => [item, isPlay];
}
class DisposeEvent extends PlayAudioEvent {
  DisposeEvent();
  @override
  List<Object?> get props => [];
}

class StopEvent extends PlayAudioEvent{
  StopEvent();
  @override
  List<Object?> get props => [];
}