import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grow_simplee/fb_model.dart';

class RiderDetails extends StatefulWidget {
  final String docid;
  const RiderDetails({required this.docid, super.key});

  @override
  State<RiderDetails> createState() => _RiderDetailsState();
}

class _RiderDetailsState extends State<RiderDetails> {
  final db = FirebaseFirestore.instance.collection('Rider').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("View Rider"),
        ),
        body: FutureBuilder(
          future: readRider(widget.docid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              final user = snapshot.data;
              return buildViewRider(user);
            } else {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          },
        ));
  }

  Widget buildViewRider(user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
          const Divider(),
          ViewRiderDetails(
            context: context,
            field: "Name: ",
            data: user['details']['name'],
          ),
          ViewRiderDetails(
            context: context,
            field: "Phone Number: ",
            data: user['details']['contactno'],
          ),
          ViewRiderDetails(
            context: context,
            field: "Address: ",
            data: user['details']['address'],
          ),
          ViewRiderDetails(
            context: context,
            field: "Localities: ",
            data: '${user['details']['localities']}',
          ),
        ],
      ),
    );
  }
}

class ViewRiderDetails extends StatelessWidget {
  final String field;
  final String data;
  const ViewRiderDetails({
    super.key,
    required this.context,
    required this.field,
    required this.data,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          // vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Text(
              field,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(data),
          ],
        ));
  }
}


// SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0),
//               height: 300,
//               width: width,
//             ),
//             const Divider(),
//             Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 10.0,
//                   horizontal: 20.0,
//                 ),
//                 padding: const EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   color: Colors.white,
//                 ),
//                 child:  Row(
//                   children: [Text('Name: '), Text(db.)],
//                 )),
//           ],
//         ),
//       ),