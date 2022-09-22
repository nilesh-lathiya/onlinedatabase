import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:onlinedatabase/insert.dart';

class frist extends StatefulWidget {
  const frist({Key? key}) : super(key: key);

  @override
  State<frist> createState() => _fristState();
}

class _fristState extends State<frist> {
  List l = [];

  bool status = false;
  int result = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllData();
  }
  getAllData() async {
    Response response = await Dio()
        .get('https://theweb94284.000webhostapp.com/nil/viewdata.php');
    print(response.data.toString());

    Map m = jsonDecode(response.data);

    int connection = m['connection'];

    if (connection == 1) {
      result = m['result'];

      if (result == 1) {
        l = m['data'];
      }
    }
    status = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("online database wiewv page"),),
      body:status
          ? (result == 1
          ? ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          Map map = l[index];

          String imageurl =
              "https://theweb94284.000webhostapp.com/nil/${map['imagname']}";
          return ListTile(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return insert();
              },)) ;
            },
           // leading: Image.network(imageurl),
            title: Text("${map['name']}"),
            subtitle: Text("${map['contact']}"),
          );
        },
      )
          : Text("No data found"))
          : Center(child: CircularProgressIndicator()), 
      floatingActionButton:FloatingActionButton(onPressed: () {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return insert();
        },)) ;


      },child: Icon(Icons.add),),

    );
  }
}
