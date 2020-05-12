import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:toggle_switch/toggle_switch.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List data1;
  List data2;

  var isSwitched = 0;

  @override
  void initState() {
    this.getjsondata(1);
    this.getjsondata(2);
  }

  Future<String> getjsondata(page_no) async {
    try {
      var response;
      if (page_no == 1)
        response = await http.get(
            'https://api.unsplash.com/collections/1580860/photos?per_page=25&client_id=LA0NDvr5M-wxZ_cmqca5QT0WoXKFL3buOn0LJqU29BA');
      else
        response = await http.get(
            'https://api.unsplash.com/collections/139386/photos?per_page=25&client_id=LA0NDvr5M-wxZ_cmqca5QT0WoXKFL3buOn0LJqU29BA');
      setState(() {
        if (page_no == 1)
          data1 = json.decode(response.body);
        else
          data2 = json.decode(response.body);
//        print(data1 );
      });
    } catch (e) {
      print(e);
    }
    return 'images fetched';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image_Viewer"),
          actions: <Widget>[],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20,
                  activeBgColor: Colors.green,
                  activeTextColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveTextColor: Colors.white,
                  labels: ['CAT', 'DECORATION'],
//                        icons: [FontAwesomeIcons.check, FontAwesomeIcons.times],
                  onToggle: (index) {
                    setState(() {
                      isSwitched = index;
                    });
                    print('switched to: $isSwitched');
                  }),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: new ListView.builder(
                itemCount: isSwitched == 1
                    ? (data1 == null ? 0 : data1.length)
                    : (data2 == null ? 0 : data2.length),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Card(
                            child: new Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  isSwitched == 1
                                      ? Image.network(
                                          data1[index]['urls']['small'],
                                          width:
                                              MediaQuery.of(context).size.width,
                                        )
                                      : Image.network(
                                          data2[index]['urls']['small'],
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )),
          ],
        ));
  }
}
