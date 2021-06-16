import 'dart:async';
import 'dart:convert';

import 'package:client/crud.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<PostResult>? postResult;
  late PostResult hasil;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tester"),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text((postResult == null) ? "masuk" : postResult.toString()),
            MaterialButton(
              color: Colors.purple,
              elevation: 8.0,
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  postResult = connectToAPI("fikri", "dev");
                });
              },
              child: Text("POST"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<PostResult> connectToAPI(String name, String job) async {
  print("future");
  String apiURL = "https://reqres.in/api/users";

  var response =
      await http.post(Uri.parse(apiURL), body: {"name": name, "job": job});
  // var jsonObject = json.decode(response.body);

  if (response.statusCode == 201) {
    print("masuk 201");
    return PostResult.createPostResult(jsonDecode(response.body));
  } else {
    print("out");
    throw Exception('Failed to create album.');
  }
}

class PostResult {
  String id;
  String name;
  String job;
  String created;

  PostResult(
      {required this.id,
      required this.name,
      required this.job,
      required this.created});

  factory PostResult.createPostResult(Map<String, dynamic> object) {
    return PostResult(
        id: object['id'],
        name: object['name'],
        job: object['job'],
        created: object['createdAt']);
  }
}
