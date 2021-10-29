import 'dart:io';

import 'package:demo_file_manager/BLOC/login/LoginScreen.dart';
import 'package:demo_file_manager/Utils/Common.dart';
import 'package:demo_file_manager/model/Item.dart';
import 'package:demo_file_manager/model/User.dart';
import 'package:demo_file_manager/repository/MyRepository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GlobalUtil {
  static int NORMAL_STATUS = 2101;
  static int SELECTED_STATUS = 2102;

  static List<Item> mapListFileToListItem(List<FileSystemEntity>? childFiles) {
    final listItems = <Item>[];
    childFiles!.forEach((e) {
      String title =
          e.path.substring(e.path.lastIndexOf('/') + 1, e.path.length);

      String type = title
          .substring(title.lastIndexOf('.') + 1, title.length)
          .toLowerCase();
      if (title.indexOf(".") < 0) {
        type = "folder";
      }
      listItems.add(new Item(
          title: title,
          type: type,
          icon: getIconItem(title, type, path: e.path),
          path: e.path));
    });
    return listItems;
  }

  static Widget? getIconItem(String title, String type,{String? path}) {
    if (GlobalUtil.AUDIOType.contains(type)) {
      return Icon(Icons.audiotrack_outlined);
    }
    if (GlobalUtil.VIDEOType.contains(type)) {
      return Icon(Icons.video_call_sharp);
    }
    if (GlobalUtil.PDFType.contains(type)) {
      return Icon(Icons.picture_as_pdf_sharp);
    }
    if (GlobalUtil.WORDType.contains(type)) {
      return Icon(Icons.text_snippet_outlined);
    }
    if (GlobalUtil.EXELType.contains(type)) {
      return Icon(Icons.text_snippet_outlined);
    }
    if (GlobalUtil.IMAGEType.contains(type)) {
      if(path != null){
        return Image.file(File(path), width: 30, height: 30);
      }
      return Icon(Icons.image_outlined);
    }
    if (title.indexOf(".") < 0) {
      return Icon(Icons.folder);
    }
    return Icon(Icons.text_snippet_sharp);
  }

  static String getFolderItem(String title, String type) {
    if (GlobalUtil.AUDIOType.contains(type)) {
      return "Audios";
    }
    if (GlobalUtil.VIDEOType.contains(type)) {
      return "videos";
    }
    if (GlobalUtil.PDFType.contains(type)) {
      return "pdfs";
    }
    if (GlobalUtil.WORDType.contains(type)) {
      return "words";
    }
    if (GlobalUtil.EXELType.contains(type)) {
      return "exels";
    }
    if (GlobalUtil.IMAGEType.contains(type)) {
      return "images";
    }
    return "others";
  }

  static final AUDIOType = {"mp3", "m3u"};
  static final VIDEOType = {"mp4"};
  static final PDFType = {"pdf"};
  static final WORDType = {"doc", "docx"};
  static final EXELType = {"xls","xlsx"};
  static final IMAGEType = {"jpg", "jpeg", "png", "gif"};
  static final FOLDER = {"folder"};
  static final FOLDER_DOCUMENT = "driver";

  static int IsAUDIOType = 1101;
  static int IsVIDEOType = 1102;
  static int IsPDFType = 1103;
  static int IsWORDType = 1104;
  static int IsEXELType = 1105;
  static int IsIMAGEType = 1106;
  static int IsFOLDER = 1107;
  static int IsOther = 1108;


  static Future<void> onSelectFile() async{
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    String pathDir = appDocDir.path;
    pathDir = pathDir + "/" + GlobalUtil.FOLDER_DOCUMENT;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if(result != null){
      List<File> files = result.paths.map((path) => File(path!)).toList();
      for(int i = 0; i< files.length; i++){
        File item = files[i];
        String fileName = result.names[i] ?? "";
        String fileType = fileName
            .substring(fileName.lastIndexOf('.') + 1, fileName.length)
            .toLowerCase();
        String folderFile = GlobalUtil.getFolderItem(fileName, fileType);
        String outputPath  = "$pathDir/$folderFile/$fileName";
        Item fileItem  = Item(title: fileName,type: fileType,path:  outputPath,icon: GlobalUtil.getIconItem(fileName, fileType));
        File file = File(outputPath);
        await file.create(recursive: true).then(
                (value) =>  item.copy(outputPath).then((value) => _onSaveDatabase(fileItem))
        );
      }
    }
  }

  static Future _onSaveDatabase(Item item) async{
    final MyRepository _myRepository = MyRepositoryImpl();
    await _myRepository.insertSingleItem(item).then(
            (value) =>print("ok"));
  }

  static Future _onSavePassowrd(User user) async{
    final MyRepository _myRepository = MyRepositoryImpl();
    await _myRepository.savePassword(user).then(
            (value) =>print("ok"));
  }

}
