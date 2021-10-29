part of 'file_bloc.dart';

@immutable
abstract class FileEvent {
  const FileEvent();
  List<Object?> get props =>[];
}


class GetListFileEvent extends FileEvent{
  GetListFileEvent();

  @override
  List<Object?> get props => [];
}
class OpenFolder extends FileEvent{
  Item? item;
  OpenFolder({this.item});

  @override
  List<Object?> get props => [item];
}

class AddNewFile extends FileEvent{
  AddNewFile();
  @override
  List<Object?> get props => [];
}

class DeleteMutilFile extends FileEvent{
  List<Item>? deleteItems;
  DeleteMutilFile({this.deleteItems});
  @override
  List<Object?> get props => [deleteItems];
}