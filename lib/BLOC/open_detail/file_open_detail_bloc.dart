import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'file_open_detail_event.dart';
part 'file_open_detail_state.dart';

class FileOpenDetailBloc extends Bloc<FileOpenDetailEvent, FileOpenDetailState> {
  FileOpenDetailBloc() : super(FileOpenDetailInitial()) {
    on<FileOpenDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
