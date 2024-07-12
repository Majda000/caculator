import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url = "https://swapi.dev/api/people"; // Corrected URL
  late List data;

  @override
  void initState() {
    super.initState();
    getJSONData();
  }

  Future<String> getJSONData() async {
    var response = await http.get(
      Uri.parse(url), // Corrected URL parsing
      headers: {"Accept": "application/json"},
    );

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Retrieve JSON via HTTP Get"),
      ),
      body: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(data[index]['name']),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
