
import 'package:appapi/controllers/databasehelpers.dart';
import 'package:appapi/main.dart';
import 'package:appapi/view/listProducts.dart';
import 'package:flutter/material.dart';



class EditProduct extends StatefulWidget {

  final List list;
  final int index;

  EditProduct({this.list, this.index});


  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {


  DataBaseHelper databaseHelper = new DataBaseHelper();

  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerStock;
  TextEditingController controllerId;

  @override
  void initState() { 

    controllerId= new TextEditingController(text: widget.list[widget.index]['id'].toString() );
    controllerName= new TextEditingController(text: widget.list[widget.index]['name'].toString() );
    controllerPrice= new TextEditingController(text: widget.list[widget.index]['price'].toString() );
    controllerStock= new TextEditingController(text: widget.list[widget.index]['stock'].toString() );
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Editar Clave"),
      ),
      body: Form(       
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              new Column(
                children: <Widget>[
                 new ListTile(
                    leading: const Icon(Icons.title, color: Colors.black),
                    title: new TextFormField(
                      controller: controllerName,
                          validator: (value) {
                            if (value.isEmpty) return "Ingresa el Titulo";
                          },
                      decoration: new InputDecoration(
                        hintText: "Titulo", labelText: "Titulo",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.account_box, color: Colors.black),
                    title: new TextFormField(
                      controller: controllerPrice,
                          validator: (value) {
                            if (value.isEmpty) return "Usuario";
                          },
                      decoration: new InputDecoration(
                        hintText: "Usuario", labelText: "Usuario",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.vpn_key, color: Colors.black),
                    title: new TextFormField(
                      controller: controllerStock,
                          validator: (value) {
                            if (value.isEmpty) return "Ingresa Contraseña";
                          },
                      decoration: new InputDecoration(
                        hintText: "Contraseña", labelText: "Contraseña",
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                  ),                                    
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new RaisedButton(
                    child: new Text("Editar",style: TextStyle(color:Colors.white),),
                    color: Colors.blueAccent,
                    onPressed: (){
                    databaseHelper.editarData(
                        controllerId.text.trim(), controllerName.text.trim(), controllerPrice.text.trim(), controllerStock.text.trim());
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new ListProducts(),
                        )
                    );
                  },
                  )
                ],
              ),
            ],
          ),
      ),
    );
  }
}