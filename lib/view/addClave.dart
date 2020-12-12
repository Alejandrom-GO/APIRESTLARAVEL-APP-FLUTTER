import 'package:appapi/controllers/databasehelpers.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class AddDataProduct extends StatefulWidget {

  AddDataProduct({Key key , this.title}) : super(key : key);
  final String title;


  @override
  _AddDataProductState createState() => _AddDataProductState();
}

class _AddDataProductState extends State<AddDataProduct> {

   DataBaseHelper databaseHelper = new DataBaseHelper();


  final TextEditingController _nameController = new TextEditingController();  
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _stockController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
     return  new Scaffold(
        appBar: AppBar(
          title:  Text('Agregar Clave'),
        ),
        body: Container(
          
          child: ListView(
            padding: const EdgeInsets.only(top: 50,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              
              Container(
                height: 50,
                child: new TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    
                    hintText: 'Titulo',
                    icon: new Icon(Icons.title),
                  ),
                ),
              ),

              Container(
                height: 50,
                child: new TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Usuario',
                    icon: new Icon(Icons.account_box),
                  ),
                ),
              ),
              
              new Padding(padding: new EdgeInsets.only(top: 10.0),),

              Container(
                height: 50,
                child: new TextField(
                  controller: _stockController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
             new Padding(padding: new EdgeInsets.only(top: 60.0),),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 100.0),
                child: new RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
                  onPressed: (){
                    databaseHelper.addDataProducto(
                        _nameController.text.trim(), _priceController.text.trim(), _stockController.text.trim());
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new MainPage(),
                        )
                    );
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Crear',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
                ),
              ),


            ],
          ),
        ),
      );
    
  }



}
