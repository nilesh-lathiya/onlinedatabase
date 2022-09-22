import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinedatabase/frist.dart';

class insert extends StatefulWidget {
  const insert({Key? key}) : super(key: key);

  @override
  State<insert> createState() => _insertState();
}

class _insertState extends State<insert> {
  final ImagePicker _picker = ImagePicker();
  String path = "";

  TextEditingController tname=TextEditingController();
  TextEditingController tcontact=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("inser page"),),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(8.0),
            child: TextField(onChanged: (value) {

            },
              controller: tname,
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
              controller: tcontact,
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
                  )
                )
            ),
          ),
          ElevatedButton(onPressed: () async {
            String nam=tname.text;
            String cnt=tcontact.text;
            DateTime dt= DateTime.now();
            String imagname = "$nam${dt.year}${dt.month}${dt.day}${dt.hour}${dt.minute}${dt.second}.jpg";
            var formData = FormData.fromMap({
              'name': nam,
              'contact': cnt,
              'file': await MultipartFile.fromFile(path, filename: imagname),
            });
            var response = await  Dio().post('https://theweb94284.000webhostapp.com/nil/insert.php', data: formData);

            print(response.data);
            Map m = jsonDecode(response.data);
            int connection = m['connection'];

            if(connection == 1)
            {
              int result = m['result'];

              if(result == 1)
              {
                print("Data Inserted...");

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return frist();
                  },
                ));
              }
              else{
                print("Data Not Inserted");
              }
            }




          }, child:Text("Insert"))

        ],
      ),

    );
  }
}
