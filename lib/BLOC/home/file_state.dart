part of 'file_bloc.dart';

@immutable
abstract class FileState {}

class FileStateInitial extends FileState {
   List<Item>? items = [];
   List<Item>? files = [];
   List<Item>? childFiles = [];

  FileStateInitial({ this.items,  this.files, this.childFiles});

  FileStateInitial updateState({Item? item}){
    return FileStateInitial(items: items ??this.items);
  }

  FileStateInitial updateListFileState({List<Item>? files}){
    return FileStateInitial(files: files);
  }

   FileStateInitial updateStateDeleteEvent(){
     return FileStateInitial();
   }

   FileStateInitial addNewFile(){
     return FileStateInitial();
   }

  @override
  List<Object?> get props =>[items, files, childFiles];
}

