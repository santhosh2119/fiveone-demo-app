import 'package:flutter/material.dart';
import './exe.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  // ignore: unused_field
  Exerices _user;
  final String postUrl = "https://reqres.in/api/users";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  Future<Exerices> createUser(String name, String job) async {
    final response = await http.post(postUrl, body: {
      "name": name,
      "job": job,
    });
    if (response.statusCode == 201) {
      final String responseString = response.body;
      return exericesFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FiveOne'),
      ),
      body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: jobController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Job',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                  textColor: Colors.blue,
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    final String name = nameController.text;
                    final String jobTitle = jobController.text;
                    final Exerices user = await createUser(name, jobTitle);
                    setState(() {
                      _user = user;
                    });
                  }),
              SizedBox(
                height: 10,
              ),
              _user == null
                  ? Container()
                  : Text(" Name is ${_user.name} And job is  ${_user.job}"),
            ],
          )),
    );
  }
}
