import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("File picker"),
      ),
      body: Column(
        children:[
          ElevatedButton(
            onPressed: () async {
                var picked = await FilePicker.platform.pickFiles();
                if (picked != null){
                print(picked.files.first.name);
            }
            }, 
            child: Text("Upload file")
        ),
        ]
      ) 
    
    );
  }
}
