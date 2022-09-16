import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class insert extends StatefulWidget {
  const insert({Key? key}) : super(key: key);

  @override
  State<insert> createState() => _insertState();
}

class _insertState extends State<insert> {
  final ImagePicker _picker = ImagePicker();
  String path = "";

  TextEditingController name=TextEditingController();
  TextEditingController contact=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("inser page"),),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(8.0),
            child: TextField(onChanged: (value) {

            },
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "enter name",
                hintText: "NAME",

              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0),
            child: TextField(onChanged: (value) {

            },
              controller: contact,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "enter contact",
                hintText: "CONTACT",

              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  showDialog(
                      builder: (context) {
                        return SimpleDialog(
                          title: Text("Select Picture"),
                          children: [
                            ListTile(
                              onTap: () async {
                                final XFile? photo = await _picker.pickImage(
                                    source: ImageSource.camera);
                                if (photo != null) {
                                  path = photo.path;
                                  setState(() {});
                                }
                                Navigator.pop(context);
                              },
                              title: Text("Camera"),
                              leading: Icon(Icons.camera_alt),
                            ),
                            ListTile(
                              onTap: () async {
                                final XFile? photo = await _picker.pickImage(
                                    source: ImageSource.gallery);

                                if (photo != null) {
                                  path = photo.path;
                                  setState(() {});
                                }
                                Navigator.pop(context);
                              },
                              title: Text("Gallery"),
                              leading: Icon(Icons.camera_alt),
                            )
                          ],
                        );
                      },
                      context: context);
                },
                child:Container(
                  height: 100,
                  width: 100,
                  child:  path.isEmpty
                      ? Image.asset(
                    "image/user.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  )
                      : Image.file(
                    File(path),
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                )
            ),
          ),
          ElevatedButton(onPressed: () {

          }, child:Text("Insert"))

        ],
      ),

    );
  }
}
