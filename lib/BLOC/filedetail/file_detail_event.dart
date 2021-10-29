part of 'file_detail_bloc.dart';

@immutable
abstract class FileDetailEvent {
  const FileDetailEvent();
  List<Object?> get props =>[];
}

class ListDetailFileEvent extends FileDetailEvent{
  Item? item;
  ListDetailFileEvent({this.item});
  @override
  List<Object?> get props => [item];
}

class OpenFileEvent extends FileDetailEvent{
  Item? item;
  OpenFileEvent({this.item});
  @override
  List<Object?> get props => [item];
}
