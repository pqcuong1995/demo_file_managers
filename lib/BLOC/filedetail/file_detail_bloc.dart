import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demo_file_manager/BLOC/filedetail/file_detail_screen.dart';
import 'package:demo_file_manager/BLOC/open_detail/FileOpenDetail.dart';
import 'package:demo_file_manager/BLOC/player_audio/play_audio_screen.dart';
import 'package:demo_file_manager/Utils/Util.dart';
import 'package:demo_file_manager/model/Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'file_detail_event.dart';
part 'file_detail_state.dart';

class FileDetailBloc extends Bloc<FileDetailEvent, FileDetailInitial> {
  final BuildContext? context;

  FileDetailBloc({this.context}) : super(FileDetailInitial(listChild: [])) {
    on<FileDetailEvent>((event, emit) async {
      if (event is ListDetailFileEvent) {
        Directory dir = Directory(event.item!.path!);
        List<FileSystemEntity> childFiles = dir.listSync(recursive: false);
        emit.call(state.updateListChildFileState(
            childFiles: GlobalUtil.mapListFileToListItem(childFiles)));
      }
      if (event is OpenFileEvent) {
        // Navigator.of(context!).push(MaterialPageRoute(builder: (context) => PlayAudio(item: event.item),));
        _onOpenFile(event.item!);
      }
    });
  }

  Future _onOpenFile(Item item) async {
    if (GlobalUtil.AUDIOType.contains(item.type) || GlobalUtil.VIDEOType.contains(item.type)) {
      Navigator.of(context!).push(MaterialPageRoute(builder: (context) => PlayAudio(item: item)));
    }else if (GlobalUtil.FOLDER.contains(item.type)) {
      Navigator.of(context!).push(MaterialPageRoute(builder: (context)=>FileDetailScreen(item: item)));
    }else{
      Navigator.of(context!).push(MaterialPageRoute(builder: (context) => FileOpenDetail(item: item)));
    }
  }
}
