
import 'dart:ffi';

import 'package:demo_file_manager/BLOC/login/login_bloc.dart';
import 'package:demo_file_manager/repository/MyRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>{
  MyRepository _repository = MyRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(repository: _repository, context: context)..add(OnCheckLogin()),
      child: BlocBuilder<LoginBloc, LoginInitial>(builder: (context, state) {
        final bloc = BlocProvider.of<LoginBloc>(context);
        return Scaffold(
          appBar: null,
          body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.blue
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              child: state.isRegistered! ? _buildWidgetLogin(bloc) : _buildWidgetRegister(bloc)
            ),
          ),
        );
      },),
    );
  }

  Widget _buildWidgetLogin(LoginBloc bloc){
    return  ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 200, bottom: 50.0),
          child: Center(
            child: Text('File security', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold),),
          ),
        ),
        TextFormField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          style: TextStyle(fontSize: 14.0, color: Color(0xFFbdc6cf)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Input your password',
            border: OutlineInputBorder(),
            contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                bloc.add(OnLoginEvent());
              },
              icon: Icon(Icons.login),
            ),
          ),
          onChanged: (value) {
            bloc.add(OnChangePassword(password: value));
          },
        )
      ],
    );
  }

  Widget _buildWidgetRegister(LoginBloc bloc){
    return  ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 200, bottom: 50.0),
          child: Center(
            child: Text('Set your password', style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold),),
          ),
        ),
        Container(
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            style: TextStyle(fontSize: 14.0, color: Color(0xFFbdc6cf)),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Input your password',
              border: OutlineInputBorder(),
              contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  bloc.add(OnLoginEvent());
                },
                icon: Icon(Icons.clear),
              ),
            ),
              onChanged: (value) {
                bloc.add(OnChangePassword(password: value ));
              },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            style: TextStyle(fontSize: 14.0, color: Color(0xFFbdc6cf)),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Confirm your password',
              border: OutlineInputBorder(),
              contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  bloc.add(OnLoginEvent());
                },
                icon: Icon(Icons.clear),
              ),
            ),
            onChanged: (value) {
              bloc.add(OnChangePassword(confirmPassword: value ));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: IconButton(
            icon: Icon(Icons.login_sharp),
            color: Colors.white,
            onPressed: () {
              bloc.add(OnRegisterEvent());
            },
          ),
        )
      ],
    );
  }
}