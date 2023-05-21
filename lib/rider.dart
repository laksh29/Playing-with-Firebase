import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_list.dart';
import 'list_view.dart';
import 'rider_form.dart';

class Rider extends StatefulWidget {
  const Rider({super.key});

  @override
  State<Rider> createState() => _RiderState();
}

class _RiderState extends State<Rider> {
  bool isVerified = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Riders"),
        actions: [buildToggle()],
      ),
      body: ShowcaseList(
        showList: isVerified ? verified : unVerified,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FormTwo(),
              // builder: (context) => const AddNewRider(),
            ),
          );
        },
        child: const Text("ADD"),
      ),
    );
  }

  Row buildToggle() {
    return Row(
      children: [
        const SizedBox(
          height: 25,
          width: 50,
          child: Text("Verified"),
        ),
        CupertinoSwitch(
          value: isVerified,
          onChanged: (value) {
            setState(
              () {
                isVerified = value;
              },
            );
          },
        ),
      ],
    );
  }
}
