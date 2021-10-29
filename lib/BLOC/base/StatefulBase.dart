import 'package:demo_file_manager/Utils/SharedPreferences.dart';
import 'package:demo_file_manager/Utils/Util.dart';
import 'package:flutter/material.dart';

abstract class StatefulBaseState<T extends StatefulWidget> extends State<T>{
  @override
  void initState() {
    SharedPreference.onCheckTokenLocal(context);
    super.initState();
  }
}