import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'functions.dart';
import 'rider_details.dart';

class DisplayList extends StatefulWidget {
  const DisplayList({
    super.key,
  });
  @override
  State<DisplayList> createState() => _DisplayListState();
}

class _DisplayListState extends State<DisplayList> {
  @override
  Widget build(BuildContext context) {
    // print(getAllRiders());
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Rider').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Text("Something went wrong \n ${snapshot.error}");
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                String docid = snapshot.data!.docs[index].id;
                String name = snapshot.data!.docs[index]["details"]["name"];
                return buildRider(name, docid);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        } else {
          return Text(snapshot.connectionState.toString());
        }
      },
    );
  }

  Widget buildRider(String title, String docid) {
    return Dismissible(
      key: Key(docid),
      secondaryBackground: const SecondBackground(),
      background: const Background(),
      child: Container(
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
        child: Text(
          title,
        ),
      ),
      onDismissed: (direction) {
        try {
          if (direction == DismissDirection.endToStart) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RiderDetails(
                    docid: docid,
                  ),
                ));
            final snackBar1 = SnackBar(
              content: Text("You have selected $title"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar1);
          } else if (direction == DismissDirection.startToEnd) {
            final snackBar2 = SnackBar(
              content: Text("you have deleted $title"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar2);
          }
        } on Exception catch (e) {
          print(e);
        }
      },
    );
  }
}
