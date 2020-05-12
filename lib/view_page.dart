import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Display Image Tutorial'),
        ),
        body: Center(
            child: Image.network(
                'https://flutter.io/images/catalog-widget-placeholder.png',
                height: 100,
                width: 150
            )
        ),
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("Image Gallery Example"),
//        ),
//        body: Center(
//          child: FutureBuilder<List<String>>(
//            future: fetchGalleryData(),
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                return GridView.builder(
//                    itemCount: snapshot.data.length,
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisCount: 2),
//                    itemBuilder: (context, index) {
//                      return Padding(
//                          padding: EdgeInsets.all(5),
//                          child: Container(
//                              decoration: new BoxDecoration(
//                                  image: new DecorationImage(
//                                      image: new NetworkImage(
//                                          snapshot.data[index]),
//                                      fit: BoxFit.cover))));
//                    });
//              }
//              return Center(child: CircularProgressIndicator());
//            },
//          ),
//        ));
//  }
//
//
//  Future<Widget> fetchAlbum() async {
//    final response = await   http.get(
//      'https://source.unsplash.com/WLUHO9A_xik/1600x900',
//        headers: {HttpHeaders.authorizationHeader: "uLA0NDvr5M-wxZ_cmqca5QT0WoXKFL3buOn0LJqU29BA"},
//    ).timeout(
//      Duration(seconds: 10),  onTimeout: () {
//      return null;
//    },);
//    final responseJson = json.decode(response.body);
//
//    return Album.fromJson(responseJson);
//  }

  Future<List<String>> fetchGalleryData() async {
    try {
//      var response = await http.get("https://api.unsplash.com/photos/?page=3,client_id=LA0NDvr5M-wxZ_cmqca5QT0WoXKFL3buOn0LJqU29BA")
      var response = await http.get("https://source.unsplash.com/WLUHO9A_xik/1600x900", headers: {
        "Authorization": "LA0NDvr5M-wxZ_cmqca5QT0WoXKFL3buOn0LJqU29BA",
        HttpHeaders.contentTypeHeader: "application/json", })
          .timeout(
        Duration(seconds: 10),  onTimeout: () { 
        return null;
      },);

      if (response.statusCode == 200) {
        return compute(parseGalleryData, response.body);
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load');
    }
  }

  List<String> parseGalleryData(String responseBody) {
    final parsed = List<String>.from(json.decode(responseBody));
    return parsed;
  }

}