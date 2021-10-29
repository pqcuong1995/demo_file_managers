import 'package:demo_file_manager/BLOC/base/StatefulBase.dart';
import 'package:demo_file_manager/BLOC/filedetail/file_detail_bloc.dart';
import 'package:demo_file_manager/Utils/Util.dart';
import 'package:demo_file_manager/model/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FileDetailScreen extends StatefulWidget {
  final Item? item;
  FileDetailScreen({this.item});

 @override
  State<StatefulWidget> createState() {
    return _FileDetailScreenFul();
  }
}

class _FileDetailScreenFul extends StatefulBaseState<FileDetailScreen> {
  @override
  void dispose() {
    print('dispose roi');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.item!.title!),
          actions: [],
        ),
        body: BlocProvider(
          create: (context) =>
          FileDetailBloc(context: context)..add(ListDetailFileEvent(item: widget.item)),
          child: BlocBuilder<FileDetailBloc, FileDetailInitial>(
            builder: (context, fileState) {
              return _buildListView(context, fileState.listChild!);
            },
          ),
        ),
    );
  }

  Widget _buildListView(BuildContext context, List<Item> listItems) {
    return ListView.builder(
        itemCount: listItems.length,
        itemBuilder: (context, index) {
          return _itemListView(context, listItems[index]);
        });
  }

  Widget _itemListView(BuildContext context, Item item) {
    return InkWell(
      onTap: () {
        BlocProvider.of<FileDetailBloc>(context).add(OpenFileEvent(item: item));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child:Row(
                  children: [
                    item.icon!,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Text(
                              item.title!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
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
                          Container(
                            width: MediaQuery.of(context).size.width*0.7,
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
                    ),
                  ],
                ),
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
}
