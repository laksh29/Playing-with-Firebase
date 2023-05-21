import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grow_simplee/style.dart';
import 'package:image_picker/image_picker.dart';

import 'rider.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});
  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool uploadB = false;

  Map<String, File?> links = {
    "Aadhar": null,
    "PAN Card": null,
    "DL": null,
    "Bank Cheque": null,
    "Photo": null,
  };

  Map<dynamic, bool> upload = {
    "Aadhar": false,
    "PAN Card": false,
    "DL": false,
    "Bank Cheque": false,
    "Photo": false,
  };
  List<String> photos = [
    "Aadhar",
    "PAN Card",
    "DL",
    "Bank Cheque",
    "Photo",
  ];
  XFile? imageFile;
  _openCamera(photo) async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      links[photo] = File(imageFile!.path);
      if (links[photo] != null) {
        upload[photo] = !upload[photo]!;
      }
      // print(links);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Documents Upload"),
      ),
      body: ListView.builder(
        itemCount: photos.length,
        itemBuilder: (BuildContext context, int index) {
          String field = photos.elementAt(index);
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: upload[field],
                    onChanged: (value) => null,
                  ),
                  buildWidth(10.0),
                  Text(photos.elementAt(index)),
                  const Spacer(),
                  viewButton(field),
                  buildWidth(10.0),
                  addButton(field),
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var check = links.containsValue(null);
          if (check == true) {
            const snackBar =
                SnackBar(content: Text("Add all images to verify"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const Rider(),
                ),
                (route) => false);
          }
        },
        child: const Text("Next"),
      ),
    );
  }

  OutlinedButton viewButton(field) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blue,
          side: const BorderSide(color: Color.fromARGB(255, 74, 20, 140)),
          elevation: 0,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(field),
                content: links[field] == null
                    ? ElevatedButton(
                        onPressed: () {
                          _openCamera(field);
                        },
                        child: const Text("Add Photo"))
                    : Image.file(File(links[field]!.path)),
              );
            },
          );
        },
        child: const Text("View"));
  }

  OutlinedButton addButton(field) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blue,
          side: const BorderSide(color: Color.fromARGB(255, 74, 20, 140)),
          elevation: 0,
        ),
        onPressed: () {
          _openCamera(field);
        },
        child: const Text("Add"));
  }
}



// GestureDetector(
//         onTap: _openGallery,
//         child: imageFile == null
//             ? Container(
//                 decoration: BoxDecoration(
//                     color: Colors.red[50],
//                     border: Border.all(color: Colors.red, width: 1.0),
//                     borderRadius: BorderRadius.circular(10.0)),
//                 child: const Column(
//                   children: <Widget>[
//                     SizedBox(height: 30.0),
//                     Icon(Icons.camera_alt, color: Colors.red),
//                     SizedBox(height: 10.0),
//                     Text('Take Image of the Item',
//                         style: TextStyle(color: Colors.red)),
//                     SizedBox(height: 30.0)
//                   ],
//                 ))
//             : Image.file(
//                 File(imageFile!.path),
//               ),
//       ),