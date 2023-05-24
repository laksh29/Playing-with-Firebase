import 'package:flutter/material.dart';
import 'package:grow_simplee/functions.dart';

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

  List<String> listOFSelectedItem = [];
  String selectedText = "";

  @override
  void initState() {
    super.initState();
    count = 0;
    data = [];
    data2 = {};
  }

  @override
  Widget build(BuildContext context) {
    Function(List<String>) selectedList = (p0) => {};
    final List<String> listOFStrings = [
      "Mumbai",
      "Delhi",
      "Nagpur",
      "Jaipur",
      "Jodhpur",
      "Hyderabad",
      "Chennai",
      "Bangalore",
      "Kolkata",
      "Pune",
      "Lucknow",
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Dynamic Form"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
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
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: buildDropdown(listOFStrings, selectedList))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            var snackbar = _validate(data2);
            if (snackbar == true) {
              if (listOFSelectedItem.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Choose atleat 1 locality")));
              } else {
                data2["localities"] = listOFSelectedItem;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddImage(data2: data2),
                  ),
                );
              }
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

  Container buildDropdown(
      List<String> listOFStrings, Function(List<String>) selectedList) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        iconColor: Colors.black,
        title: Text(
          listOFSelectedItem.isEmpty
              ? "Select 3 Localities"
              : listOFSelectedItem.length == 1
                  ? listOFSelectedItem[0]
                  : listOFSelectedItem.length == 2
                      ? "${listOFSelectedItem[0]}, ${listOFSelectedItem[1]}"
                      : "${listOFSelectedItem[0]}, ${listOFSelectedItem[1]}, ${listOFSelectedItem[2]}",
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
          ),
        ),
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listOFStrings.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: ViewItem(
                  item: listOFStrings[index],
                  selected: (val) {
                    selectedText = val;
                    if (listOFSelectedItem.contains(val)) {
                      listOFSelectedItem.remove(val);
                    } else {
                      listOFSelectedItem.add(val);
                    }
                    selectedList(listOFSelectedItem);
                    setState(() {});
                  },
                  deselected: (val) {
                    selectedText = val;
                    if (listOFSelectedItem.contains(val)) {
                      listOFSelectedItem.remove(val);
                    }
                    selectedList(listOFSelectedItem);
                    setState(() {});
                  },
                  itemSelected:
                      listOFSelectedItem.contains(listOFStrings[index]),
                  three: listOFSelectedItem.length == 3 ||
                          listOFSelectedItem.length > 3
                      ? true
                      : false,
                ),
              );
            },
          ),
        ],
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
