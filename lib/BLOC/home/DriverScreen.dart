import 'package:demo_file_manager/BLOC/base/StatefulBase.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:demo_file_manager/BLOC/home/file_bloc.dart';
import 'package:demo_file_manager/Utils/Constants.dart';
import 'package:demo_file_manager/Utils/NavDrawer.dart';
import 'package:demo_file_manager/Utils/Util.dart';
import 'package:demo_file_manager/model/Item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  List<Item> listSelected = [];
  int isStatus = GlobalUtil.NORMAL_STATUS;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends StatefulBaseState<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FileBloc(context: context)..add(GetListFileEvent()),
      child: BlocBuilder<FileBloc, FileStateInitial>(
        builder: (context, fileState) {
          return _buildListView(context, fileState.files!);
        },
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<Item> listItems) {
    final bloc = BlocProvider.of<FileBloc>(context);
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Driver"),
          actions: <Widget>[
            (() {
              if (widget.isStatus == GlobalUtil.SELECTED_STATUS) {
                return TextButton(
                    onPressed: () async {
                      if (await confirm(context)) {
                        bloc.add(
                            DeleteMutilFile(deleteItems: widget.listSelected));
                        return setState(() {
                          widget.isStatus = GlobalUtil.NORMAL_STATUS;
                          widget.listSelected = [];
                        });
                      }
                      return print('Cancel');
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ));
              } else {
                return Container();
              }
            }()),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.isStatus == GlobalUtil.SELECTED_STATUS) {
                      widget.isStatus = GlobalUtil.NORMAL_STATUS;
                      widget.listSelected = [];
                    } else {
                      widget.isStatus = GlobalUtil.SELECTED_STATUS;
                    }
                  });
                },
                icon: widget.isStatus == GlobalUtil.NORMAL_STATUS
                    ? Icon(Icons.radio_button_checked)
                    : Icon(Icons.done)),
            PopupMenuButton<String>(onSelected: (value) {
              menuAction(value, bloc);
            }, itemBuilder: (context) {
              return Constants.menus.map((String menu) {
                return PopupMenuItem<String>(value: menu, child: Text(menu));
              }).toList();
            })
          ],
        ),
        body: (() {
          if (listItems.length == 0) {
            return Center(
                child: ListView(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Your driver dont have item!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey)),
                  ),
                  margin: EdgeInsets.only(top: 100.0, bottom: 50.0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.download_outlined,
                    color: Colors.blue,
                    size: 50.0,
                  ),
                  onPressed: () {
                    bloc.add(AddNewFile());
                  },

                )
              ],
            ));
          } else {
            return ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (context, index) {
                  return _itemListView(context, listItems[index]);
                });
          }
        }()));
  }

  Widget _itemListView(BuildContext context, Item item) {
    return InkWell(
      onTap: () {
        if (widget.isStatus == GlobalUtil.SELECTED_STATUS) {
          setState(() {
            if (widget.listSelected.contains(item)) {
              widget.listSelected.remove(item);
            } else {
              widget.listSelected.add(item);
            }
          });
        } else {
          BlocProvider.of<FileBloc>(context).add(OpenFolder(item: item));
        }
      },
      onLongPress: () {
        setState(() {
          widget.isStatus = GlobalUtil.SELECTED_STATUS;
          widget.listSelected.add(item);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: (() {
                    return [
                      widget.isStatus == GlobalUtil.NORMAL_STATUS
                          ? item.icon!
                          : widget.listSelected.contains(item)
                              ? Icon(Icons.radio_button_checked,
                                  color: Colors.blue)
                              : Icon(Icons.radio_button_off)
                    ];
                  }()),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              item.title!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            item.type!,
                            style: TextStyle(
                                fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              item.path!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 13),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 10,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void menuAction(String item, FileBloc bloc) {
    if (item == Constants.ADD) {
      bloc.add(AddNewFile());
    } else if (item == Constants.Refresh) {
      bloc.add(GetListFileEvent());
    }
  }

  void menuSelected(String item, FileBloc bloc) {
    if (item == Constants.DELETE) {}
  }
}
