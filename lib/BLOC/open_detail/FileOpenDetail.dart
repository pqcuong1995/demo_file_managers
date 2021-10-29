import 'dart:io';

import 'package:demo_file_manager/BLOC/base/StatefulBase.dart';
import 'package:demo_file_manager/Utils/Util.dart';
import 'package:demo_file_manager/model/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class FileOpenDetail extends StatefulWidget {
  final Item? item;
  FileOpenDetail({this.item});
  @override
  State<StatefulWidget> createState() {
    return FileOpenDetailState();
  }
}

class FileOpenDetailState extends StatefulBaseState<FileOpenDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item!.title!),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: (() {
            if (_checkIsTypeFile() == GlobalUtil.IsIMAGEType) {
              return _buildImageView();
            } else if (_checkIsTypeFile() == GlobalUtil.IsPDFType) {
              return _buildPdfView();
            } else {

              return _buildPdfView();
            }
          }()),
        )
      ),
    );
  }

  Widget _buildImageView() {
    return Image.file(File(widget.item!.path!), width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,);
  }



  Widget _buildPdfView() {
    return PDFView(
      filePath: widget.item!.path!,
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: false,
      onRender: (_pages) {
        setState(() {});
      },
      onError: (error) {
        print(error.toString());
      },
      onPageError: (page, error) {
        print('$page: ${error.toString()}');
      },
      onViewCreated: (PDFViewController pdfViewController) {},
      onPageChanged: (page, total) {
        print('page change: $page/$total');
      },
    );
  }

  int _checkIsTypeFile() {
    String type = widget.item!.type!.toLowerCase();
    if (GlobalUtil.AUDIOType.contains(type)) {
      return GlobalUtil.IsAUDIOType;
    }
    if (GlobalUtil.WORDType.contains(type)) {
      return GlobalUtil.IsWORDType;
    }
    if (GlobalUtil.EXELType.contains(type)) {
      return GlobalUtil.IsEXELType;
    }
    if (GlobalUtil.PDFType.contains(type)) {
      return GlobalUtil.IsPDFType;
    }
    if (GlobalUtil.VIDEOType.contains(type)) {
      return GlobalUtil.IsVIDEOType;
    }
    if (GlobalUtil.IMAGEType.contains(type)) {
      return GlobalUtil.IsIMAGEType;
    }
    if (GlobalUtil.FOLDER.contains(type)) {
      return GlobalUtil.IsFOLDER;
    }
    return GlobalUtil.IsOther;
  }
}
