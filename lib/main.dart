import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(

  home: HomePage(),

));

class HomePage extends StatefulWidget{

  @override
  HomePageState createState() => new HomePageState();

}

class HomePageState extends State<HomePage> {

  final String url = "https://jsonplaceholder.typicode.com/albums/";
  List data;


  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
      //encode the url
      Uri.encodeFull(url),
      //only aceept json response
      headers: {
        "Accept": "application/json"
      }
    );
    print(response.body);

    setState(() {


      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson;
    });

    return "success" ;


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve Json"),
      ),

      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      child: Text(data[index]["title"]),
                      padding: EdgeInsets.all(20),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: data == null ? 0 : data.length,
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.refresh
        ),
        onPressed: getJsonData,
      ),
    );
  }


}
