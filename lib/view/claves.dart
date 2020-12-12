import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detailClave.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

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



  @override
  Widget build(BuildContext context) {
     return new Scaffold(
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