import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'fb_model.dart';
import 'rider.dart';
import 'style.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key, required this.data2});
  final Map data2;
  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool uploadB = false;

  Map<String, String?> links = {
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
  _openCamera(field) async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      // links[field] = File(imageFile!.path);
      // if (links[field] != null) {
      //   upload[field] = !upload[field]!;
      // }
      // print(links);
      uploadImageToFirebase(context, imageFile, field);
    });
  }

  Future uploadImageToFirebase(
      BuildContext context, imageCaptured, field) async {
    // imageCaptured will replacee links['aadhar']
    final pickedFile = imageCaptured;

    final path = 'uploads/${widget.data2['name']}/$field';
    final file = File(pickedFile!.path);

    final storageRef = FirebaseStorage.instance.ref().child(path);
    final uploadImage = storageRef.putFile(file);

    final imageSnapshot = await uploadImage.whenComplete(() {});

    final url = await imageSnapshot.ref.getDownloadURL();

    links[field] = url.toString();
    upload[field] = !upload[field]!;

    // then((value) {
    //   links[field] = value;
    //   print(links);
    //   upload[field] = !upload[field]!;
    // });
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
            riderData(
              name: widget.data2['name'],
              contactno: widget.data2['contactno'],
              address: widget.data2['address'],
              pincode: widget.data2['pincode'],
              accountno: widget.data2['accountno'],
              ifsc: widget.data2['ifsc'],
              localities: widget.data2['localities'],
              aadhar: '${links['Aadhar']}',
              pancard: '${links['PAN Card']}',
              dl: '${links['DL']}',
              bankcheque: '${links['Bank Cheque']}',
              photo: '${links['Photo']}',
            );
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
                      :
                      // Image.file(File(links[field]!.path)),
                      Image.network(links[field].toString()));
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
