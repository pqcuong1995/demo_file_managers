part of 'file_detail_bloc.dart';

@immutable
abstract class FileDetailState {}

class FileDetailInitial extends FileDetailState {
  final List<Item>? listChild;
  FileDetailInitial({this.listChild});

  @override
  List<Object?> get props =>[];

  FileDetailInitial updateListChildFileState({List<Item>? childFiles}){
    return FileDetailInitial(listChild: childFiles);
  }
  FileDetailInitial updateStateOpenFile(){
    return FileDetailInitial();
  }
}
