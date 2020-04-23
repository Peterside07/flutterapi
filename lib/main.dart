import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    var user = new List<User>();

    _getUser(){
      API.getUsers().then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          user = list.map((model) => User.fromJson(model)).toList();
        });
      });

    }

    initState() {
      super.initState();
      _getUser();
    }

    dispose() {
      super.dispose();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
            future: _getUser(),
            builder: (context, index) {
              return ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return ListTile(
                      leading: CircleAvatar(),
                      title: Text(user[index].name),
                      subtitle: Text(user[index].email),
                      onTap: (){
                        Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => UserDetail(user[index]),
                        ));

                      },
                    );
                  });
            }
            )
      )
    );


              }
            }





const baseUrl = "https://jsonplaceholder.typicode.com/users";
class API {
  static Future getUsers() {
    var url = baseUrl;
    return http.get(url);
  }
}

class User {
  int id;
  String phone;
  String name;
  String email;
  String username;


  User(int id, String name, String email, String phone, String username) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.username = username;
  }

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        username = json['username'];

  Map toJson() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone, 'username': username};
  }
}


class UserDetail extends StatelessWidget {

  final User user;
  UserDetail(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Container
        (
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Text("Name: " + user.name),
               SizedBox(height: 10.0,),
               Text("UserName: " + user.username),
                SizedBox(height: 10.0,),
               Text("Email: " + user.email),
                SizedBox(height: 10.0,),
                Text("Phone: " + user.phone),
              ],
            ),
          ),
        ),
      );
  }
}

