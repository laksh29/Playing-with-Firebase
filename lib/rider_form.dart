import 'package:flutter/material.dart';

import 'style.dart';
import 'trial.dart';
import 'validators.dart';

class FormTwo extends StatefulWidget {
  const FormTwo({super.key});

  @override
  State<FormTwo> createState() => _FormTwoState();
}

class _FormTwoState extends State<FormTwo> {
  late int count;
  late List<Map<String, dynamic>> data;
  late Map<String, dynamic> data2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> fields = [
    "name",
    "contactno",
    "address",
    "pincode",
    "accountno",
    "ifsc",
  ];

  @override
  void initState() {
    super.initState();
    count = 0;
    data = [];
    data2 = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Dynamic Form"),
      ),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: fields.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: buildRow(index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final snackbar = _validate(data2);
            if (snackbar == true) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  // builder: (context) => const UploadFiles(),
                  builder: (context) => const AddImage(),
                ),
              );
            } else {
              final snackBar = SnackBar(content: Text(snackbar));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
        child: const Text("Next"),
      ),
    );
  }

  TextFormField buildRow(int index) {
    String fieldName = fields.elementAt(index);

    return TextFormField(
      decoration: InputDecoration(
        labelText: fieldName,
        hintStyle: buildHintStyle(),
        enabledBorder: buildBorder(Colors.black),
        focusedBorder: buildBorder(Colors.black),
        errorBorder: buildBorder(Colors.red),
      ),
      keyboardType: [
        "contactno",
        "pincode",
        "accountno",
        // "ifsc",
      ].contains(fieldName)
          ? TextInputType.number
          : TextInputType.name,
      onChanged: (value) {
        _onUpdate(
          fieldName,
          value,
        );
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Mandatory to fill";
        } else {
          return null;
        }
      },
    );
  }

  _onUpdate(String keyName, String val) async {
    String foundKey = "none";
    for (var key in data2.keys) {
      if (key == keyName) {
        foundKey = keyName;
      }
    }

    if ("none" != foundKey) {
      data2.remove(foundKey);
    }

    Map<String, dynamic> json = {keyName: val};
    data2.addEntries(json.entries);
  }

  _validate(Map data2) {
    late bool isNumber;
    late bool isCode;
    // String snackbar;
    for (var key in data2.keys) {
      if (key == "contactno") {
        isNumber = isPhoneNumber(data2[key]);
      } else if (key == "pincode") {
        isCode = isPincode(data2[key]);
      }
    }
    if (isNumber == true && isCode == true) {
      return true;
    } else if (isNumber == false && isCode == false) {
      return "Make sure your contact is 9 digits and pincode is 6 digits";
    } else if (isCode == false) {
      return "Make sure your Pincode is 6 digits";
    } else if (isNumber == false) {
      return "Make sure your mobile number is 9 digits";
    }
  }
}
