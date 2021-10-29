import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:demo_file_manager/Utils/Util.dart';
import 'package:demo_file_manager/model/Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../filedetail/file_detail_screen.dart';
part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileStateInitial> {
  final BuildContext? context;

  FileBloc({this.context}) : super(FileStateInitial(items: null, files: [])) {
    on<FileEvent>((event, emit) async {
      if (event is GetListFileEvent) {
        var files = await getListFile();
        emit.call(state.updateListFileState(files: files));
      }

      if (event is OpenFolder) {
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (context) => FileDetailScreen(
                  item: event.item!,
                )));
      }

      if (event is AddNewFile) {
        await GlobalUtil.onSelectFile().then((value) async {
            var file = await getListFile();
            emit.call(state.updateListFileState(files: file));
        });
      }

      if(event is DeleteMutilFile){
        List<Item>? deleteLists = event.deleteItems;
        if(deleteLists!.length != 0){
          deleteLists.forEach((Item item) {
            if(GlobalUtil.FOLDER.contains(item.type)){
              Directory(item.path!).deleteSync(recursive: true);
            }else{
              File(item.path!).deleteSync(recursive: true);
            }
          });
          var file = await getListFile();
          emit.call(state.updateListFileState(files: file));
        }
      }
    });
  }

  Future<List<Item>?> getListFile() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    Directory directory = await getExternalSdCardPath();
    var files;
    if (await Permission.storage.request().isGranted) {
      files = directory.listSync();
    }
    return GlobalUtil.mapListFileToListItem(files);
  }

  Future<Directory> getExternalSdCardPath() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    String appPath = appDocDir.path;
    appPath = appPath + "/" + GlobalUtil.FOLDER_DOCUMENT;
    bool isDirExits = await Directory(appPath).exists();
    if (!isDirExits) {
      Future<Directory> newDr = Directory(appPath).create(recursive: true);
      return newDr;
    }
    return new Directory(appPath);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
