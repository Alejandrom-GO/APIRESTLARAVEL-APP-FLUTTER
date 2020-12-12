
import 'package:appapi/controllers/databasehelpers.dart';
import 'package:flutter/material.dart';

import 'editClave.dart';
import 'listProducts.dart';

class Detail extends StatefulWidget {

  List list;
  int index;
  Detail({this.index,this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {


  DataBaseHelper databaseHelper = new DataBaseHelper();

  //create function delete 
  void confirm (){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Esta seguro de eliminar ${widget.list[widget.index]['name']}"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text("Cancelar",style: new TextStyle(color: Colors.white)),
        color: Colors.green,
        onPressed: ()=> Navigator.pop(context),
      ),
      new RaisedButton(
        child: new Text("Eliminar",style: new TextStyle(color: Colors.white),),
        color: Colors.red,
        onPressed: (){
                      databaseHelper.removeRegister(widget.list[widget.index]['id'].toString());
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new ListProducts(),
                          )
                      );
                    },
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}


  @override
  Widget build(BuildContext context) {
     return new Scaffold(
      appBar: new AppBar(title: new Text(widget.list[widget.index]['name'])),
      body: new Container(
        height: 270.0, 
        padding: const EdgeInsets.all(2.0),
        
        child: new Card(  
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        
        child: Container(
   
              child: new Column(
                 
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top: 20.0,),),
                  new Text(widget.list[widget.index]['name'], style: new TextStyle(fontSize: 25.0),),
                  new Padding(padding: const EdgeInsets.all(10.0),),
                  Divider(),
                  
                  new Text("Usuario :"+ widget.list[widget.index]['price'], style: new TextStyle(fontSize: 18.0),),
                  new Padding(padding: const EdgeInsets.all(10.0),),
                    Divider(),
                  new Text("Contraseña : "+ widget.list[widget.index]['stock'], style: new TextStyle(fontSize: 18.0),),
                  new Padding(padding: const EdgeInsets.all(10.0),),

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new RaisedButton(
                      child: new Text("Editar", style: TextStyle(color:Colors.white),),                  
                      color: Colors.blueAccent,
                      shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: ()=>Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context)=>new EditProduct(list: widget.list, index: widget.index,),
                          )
                        ),                    
                    ),
                    VerticalDivider(),
                    new RaisedButton(
                      child: new Text("Borrar", style: TextStyle(color:Colors.white),),                   
                      color: Colors.redAccent,
                      shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: ()=>confirm(),                
                    ),
                    ],
                  )
                ],
              ),
            ),
          
        ),
      ),
    );
  }
}