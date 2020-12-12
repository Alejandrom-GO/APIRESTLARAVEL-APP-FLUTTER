import 'dart:convert';


import 'package:appapi/view/addClave.dart';
import 'package:appapi/view/addUser.dart';
import 'package:appapi/view/claves.dart';
import 'package:appapi/view/listProducts.dart';
import 'package:appapi/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        accentColor: Colors.white70
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Baul de Claves", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()),
                 (Route<dynamic> route) => false);
            },
            child: Text("Salir", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Products(),
      drawer: Drawer(
        child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text('Bienvenido',
                  style: TextStyle( fontSize: 30.0,
                  fontWeight: FontWeight.bold,)),
                  accountEmail: new Text(''),
                 
                ),
               new ListTile(
                  title: new Text("Tus Claves"),
                  trailing: new Icon(Icons.security),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => ListProducts(),
                  )),
                ),
                 new Divider(),
                new ListTile(
                  title: new Text("Añadir Nueva Clave"),
                  trailing: new Icon(Icons.add_circle_outline),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AddDataProduct(),
                  )),
                ),
                
                 
              ],
            ),
      ),
    );
  }
}
