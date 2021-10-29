import 'package:demo_file_manager/BLOC/home/DriverScreen.dart';
import 'package:demo_file_manager/BLOC/welcome/WelcomeScreen.dart';
import 'package:demo_file_manager/Utils/Common.dart';
import 'package:demo_file_manager/Utils/SharedPreferences.dart';
import 'package:demo_file_manager/Utils/Util.dart';
import 'package:flutter/material.dart';
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/icons.png'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomeScreen(),))
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Driver'),
            onTap: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(),))},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {SharedPreference.deleteTokenShared(context)},
          ),
        ],
      ),
    );
  }
}