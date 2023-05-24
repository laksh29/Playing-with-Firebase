import 'package:flutter/material.dart';
import 'package:grow_simplee/fb_model.dart';

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
    return StreamBuilder<List<RiderData>>(
      stream: getAllRiders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Text("Something went wrong \n ${snapshot.error}");
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            // print(users);

            return ListView(
              children: users.map(buildRider).toList(),
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

  Widget buildRider(RiderData rider) {
    // print(rider);
    return ListTile(
      title: Text(rider.name.toString()),
    );
  }
}
