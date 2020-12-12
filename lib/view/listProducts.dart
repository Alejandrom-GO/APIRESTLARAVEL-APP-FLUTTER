import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'addClave.dart';
import 'detailClave.dart';
import 'login.dart';

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  SharedPreferences sharedPreferences;
  List data;

  Future<List> getData() async {
    final response = await http.get("http://192.168.0.122:8000/api/products");
    return json.decode(response.body);
  }

  @override
  void initState() { 
    super.initState();
     this.getData();
  }
checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }


  @override
  Widget build(BuildContext context) {
     return new Scaffold(
      appBar: new AppBar(
        title: new Text("Baul de Claves"),
        actions: <Widget>[
FlatButton(
            onPressed: () {
              
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()),
                 (Route<dynamic> route) => false);
            },
            child: Text("Salir", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
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

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new Detail(
                            list: list,
                            index: i,
                          )),
                ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['name'].toString(),
                  style: TextStyle(fontSize: 25.0, color: Colors.blue,
                  fontWeight: FontWeight.bold),
                ),
                subtitle: new Text("Creada:"+" "+list[i]['fecha'].toString()),
               
               
              ),
            ),
          ),
        );
      },
    );
  }
}