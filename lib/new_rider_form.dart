import 'package:flutter/material.dart';
import 'package:grow_simplee/validators.dart';

import 'style.dart';

class AddNewRider extends StatefulWidget {
  const AddNewRider({super.key});

  @override
  State<AddNewRider> createState() => _AddNewRiderState();
}

class _AddNewRiderState extends State<AddNewRider> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController ifsc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Add New Rider"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildName(),
              buildHeight(20.0),
              buildNumber(),
              buildHeight(20.0),
              // Localities drop down
              buildAddress(),
              buildHeight(20.0),
              buildPincode(),
              buildHeight(20.0),
              buildBank(),
              buildHeight(20.0),
              buildIfsc(),
              buildHeight(10.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      const snackBar =
                          SnackBar(content: Text("Data collected"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      name.clear();
                      number.clear();
                      // localities doen down
                      address.clear();
                      pincode.clear();
                      bank.clear();
                      ifsc.clear();
                    }
                  },
                  child: const Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildIfsc() {
    return TextFormField(
      controller: ifsc,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your IFSC Number";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: 'IFSC Number',
        hintText: "9512847630",
        hintStyle: buildHintStyle(),
        enabledBorder: buildBorder(Colors.black),
        focusedBorder: buildBorder(Colors.black38),
        errorBorder: buildBorder(Colors.red),
      ),
    );
  }

  TextFormField buildBank() {
    return TextFormField(
      controller: bank,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your Bank Account Number";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: 'Bank Account Number',
        hintText: "9512847630",
        hintStyle: buildHintStyle(),
        enabledBorder: buildBorder(Colors.black),
        focusedBorder: buildBorder(Colors.black38),
        errorBorder: buildBorder(Colors.red),
      ),
    );
  }

  TextFormField buildPincode() {
    return TextFormField(
      controller: pincode,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your Pincode";
        } else if (isPincode(value) == false) {
          return "Seems like your 6 digits aren't corrent :(";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: 'Pincode',
        hintText: "123456",
        hintStyle: buildHintStyle(),
        enabledBorder: buildBorder(Colors.black),
        focusedBorder: buildBorder(Colors.black38),
        errorBorder: buildBorder(Colors.red),
      ),
    );
  }

  TextFormField buildAddress() {
    return TextFormField(
      controller: address,
      // keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your Current Address";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: 'Current Address',
        hintText: "3-5-210, Banglore, India",
        hintStyle: buildHintStyle(),
        enabledBorder: buildBorder(Colors.black),
        focusedBorder: buildBorder(Colors.black38),
        errorBorder: buildBorder(Colors.red),
      ),
    );
  }

  TextFormField buildName() {
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your Name";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: 'Full Name',
        hintText: "Grow Simplee",
        hintStyle: buildHintStyle(),
        enabledBorder: buildBorder(Colors.black),
        focusedBorder: buildBorder(Colors.black38),
        errorBorder: buildBorder(Colors.red),
      ),
    );
  }

  TextFormField buildNumber() {
    return TextFormField(
      controller: number,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your Contact Number";
        } else if (isPhoneNumber(value) == false) {
          return "Seems like your 9 digits aren't corrent :(";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: 'Contact Number',
        hintText: "9512847630",
        hintStyle: buildHintStyle(),
        enabledBorder: buildBorder(Colors.black),
        focusedBorder: buildBorder(Colors.black38),
        errorBorder: buildBorder(Colors.red),
      ),
    );
  }
}
