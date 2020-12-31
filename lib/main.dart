import 'dart:convert';

import 'package:fiveonedemo/add.dart';

import './exerices_hub.dart'; // import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'StudentModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FiveOne',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HttpScreen(),
    );
  }
}

class HttpScreen extends StatefulWidget {
  @override
  _HttpScreenState createState() => _HttpScreenState();
}

class _HttpScreenState extends State<HttpScreen> {
  final String apiUrl = "https://reqres.in/api/users?page=2";
  // final String delUrl = "https://reqres.in/api/users/2";
  ExericesHub exericesHub;
  @override
  void initState() {
    getExerices();

    super.initState();
  }

  void getExerices() async {
    var response = await http.get(apiUrl);
    var body = response.body;
    var decodedJson = jsonDecode(body);
    exericesHub = ExericesHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FiveOne'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Add()),
                );
              })
        ],
      ),
      body: Container(
        child: Container(
          child: ListView.builder(
            itemCount: exericesHub == null ? 0 : exericesHub.data.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    color: Colors.blueGrey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          child: Text(
                            exericesHub.data[index].email,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text("Delet!!"),
                        content: Text('Do you really wanna delet  this name?'),
                        actions: [
                          FlatButton(
                            onPressed: () {},
                            child: Text('Yes'),
                          ),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No')),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
