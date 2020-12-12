import 'dart:convert';

import 'package:appapi/view/addUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue[50], Colors.teal],
              begin: Alignment.bottomCenter,
              end: Alignment.centerRight),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
            createusers(),
          ],
        ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass
    };
    var jsonResponse;

    var response = await http.post('http://192.168.0.122:8000/api/login', body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
          

        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 80.0),
      margin: EdgeInsets.only(top: 50.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.0,
        color: Colors.blue,
        child: Text("Ingresar", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();


  Container textSection() {
   
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:BorderRadius.circular(40),
        boxShadow: [BoxShadow(
          color:Color.fromRGBO(136, 136, 136, 3),
          blurRadius: 20,
          offset: Offset(0, 9)
          
        )]
      ),
      padding: EdgeInsets.fromLTRB( 20.0,40.0,20.0,50.0),
      child: Column(
        children: <Widget>[
          TextFormField(

            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.blue,

            style: TextStyle(color: Colors.blue),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.blue),
              hintText: "Email",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent,),borderRadius: BorderRadius.circular(10)),
              hintStyle: TextStyle(color: Colors.blue),
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.blue),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.blue),
              hintText: "Password",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0,bottom: 40.0,),
      padding: EdgeInsets.fromLTRB( 80.0, 30.0,20.0,20.0),
      child: Text("Login",
          style: TextStyle(
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.bold,)
              ),
              
    );

  }
  
  Container createusers() {
    return Container(
      padding: EdgeInsets.only(left: 90.0,top:20.0),
              child: ListTile(
                  title: new Text("Crear Cuenta" ,style: TextStyle(color: Colors.blueGrey),),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AddUser(),
                  )),
                ),
    );

  }

   
 
}
