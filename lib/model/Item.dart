import 'package:flutter/material.dart';

class ItemFields {
  static final List<String> value = [
    cId,
    cTitle,
    ctype,
    cicon,
    cPath
  ];
  static String cId = "_id";
  static String cTitle = "title";
  static String ctype = "type";
  static String cicon = "icon";
  static String cPath = "path";
}

class Item {
  int id = 0;
  String? title;
  String? type;
  Widget? icon;
  String? path;

  Item({
    this.title,
    this.type,
    this.icon,
    this.path,
  });
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      ItemFields.cTitle: title,
      ItemFields.ctype: type,
      ItemFields.cPath: path
    };
    if (id != 0) {
      map[ItemFields.cId] = id;
    }
    return map;
  }

  Item.fromMap(Map<String, Object?> map) {
    id = map[ItemFields.cId] != null ? map[ItemFields.cId] as int : 0;
    title = map[ItemFields.cTitle] as String;
    type = map[ItemFields.ctype] as String;
    path = map[ItemFields.cPath] as String;
  }
}
