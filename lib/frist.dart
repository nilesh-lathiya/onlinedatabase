import 'package:flutter/material.dart';

class frist extends StatefulWidget {
  const frist({Key? key}) : super(key: key);

  @override
  State<frist> createState() => _fristState();
}

class _fristState extends State<frist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("online database wiewv page"),),
      floatingActionButton:FloatingActionButton(onPressed: () {

      },child: Icon(Icons.add),),

    );
  }
}
